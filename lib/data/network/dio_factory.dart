import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/constants.dart';
import 'package:elevator/app/functions.dart';
import 'package:elevator/presentation/login/login_view.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:elevator/data/mappers/error_response_mapper.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String LANGUAGE = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> createConfiguredDio() async {
    // Base configuration for Dio
    final baseDioOptions = BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
      headers: {ACCEPT: APPLICATION_JSON, CONTENT_TYPE: APPLICATION_JSON},
      receiveDataWhenStatusError: true,
      //  Sets maximum time to wait for sending/receiving data before giving up
      sendTimeout: const Duration(seconds: Constants.timeout),
      receiveTimeout: const Duration(seconds: Constants.timeout),
      // Dio will treat only 200–399 responses as success and send everything else (like 401, 404, 500) to onError in your InterceptorsWrapper.
      validateStatus: (status) =>
          status != null &&
          status >= 200 &&
          status < 400, // Accept status codes from 200-399
    );

    final dioInstance = Dio(baseDioOptions);

    //  Interceptors are like middleware - they run before every request and after every response.
    dioInstance.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
              // User makes API call → GET /api/profile
              // Interceptor triggers → "Wait! Let me add the auth token first"
              // Calls _addAuthorizationHeaderIfLoggedIn()
              // Adds header → Authorization: Bearer abc123xyz
              // Sends modified request to server
              await _addAuthorizationHeaderIfLoggedIn(options);
              handler.next(options);
            },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (_isUnauthorizedError(error)) {
            // Is it a 401?
            if (_isSessionExpired(error)) {
              // Is it REALLY session expiry?
              await _handleUnauthorizedError(error, handler); // Logout the user
            } else {
              handler.next(error); // Just a regular 401, pass it along
            }
          } else {
            handler.next(error);
          }
        },
      ),
    );

    // Add pretty logging for development
    if (!kReleaseMode) {
      dioInstance.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
    }

    return dioInstance;
  }

  // Automatically adds the token to every API call so you don't have to do it manually.
  Future<void> _addAuthorizationHeaderIfLoggedIn(RequestOptions options) async {
    try {
      final accessToken = await _appPreferences.getUserToken("login");
      final tokenType = await _appPreferences.getUserToken("tokenType");

      if (_isUserLoggedIn(accessToken)) {
        options.headers["Authorization"] = "$tokenType $accessToken";
      } else {
        options.headers.remove("Authorization");
      }
    } catch (error) {
      debugPrint("⚠️ Failed to attach authorization header: $error");
    }
  }

  bool _isUserLoggedIn(String token) => token.isNotEmpty;

  bool _isUnauthorizedError(DioException error) =>
      error.response?.statusCode == 401;

  /// Inspect the error response body to decide if a 401 is due to an
  /// expired session (server indicates session/token expiry) or some
  /// other client/auth error (wrong credentials, invalid OTP, etc.).
  /// Inspect the error response body to decide if a 401 is due to an
  /// expired session. Since the server only sends "Unauthorized" for
  /// session expiry, we just check for that specific message.
  bool _isSessionExpired(DioException error) {
    try {
      final data = error.response?.data as Map<String, dynamic>?;

      final message = data?.toDomain() ?? '';
      // final lowered = message.toLowerCase();
      print('🔍 401 Error message: $message');

      // Check if the message contains "unauthorized"
      return message.contains('Unauthenticated.');
    } catch (e) {
      debugPrint('⚠️ Failed to parse 401 body for session expiry: $e');
      return false;
    }
  }

  Future<void> _handleUnauthorizedError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint("🔒 Unauthorized request detected (401). Forcing logout...");

    try {
      await _forceLogout();

      handler.next(error);
    } catch (e) {
      debugPrint("⚠️ Failed to handle unauthorized error: $e");
      handler.next(error);
    }
  }

  Future<void> _forceLogout() async {
    debugPrint("🚪 Logging out user and navigating to login...");

    await _appPreferences.logOut();

    final context = navigatorKey.currentContext;
    if (context != null) {
      context.go(LoginView.loginRoute);
      Navigator.pop(context);
      Future.delayed(const Duration(seconds: 1), () {
        _showDialogWidget(
          context,
          image: JsonAssets.errorState,
          title: Strings.sessionExpired.tr(),
          description: Strings.sessionExpiredMessage.tr(),
        );
      });
    } else {
      debugPrint("⚠️ Could not navigate to login — context not found.");
    }
  }

  void _showDialogWidget(
    BuildContext context, {
    required String image,
    required String title,
    String? description,
  }) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          height: AppSize.s255.h,
          padding: EdgeInsets.all(AppPadding.p16.r),
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(AppSize.s30.r),
            boxShadow: const [BoxShadow(color: Colors.black26)],
          ),
          child: Column(
            children: [
              Lottie.asset(
                image,
                height: AppSize.s100.h,
                width: AppSize.s100.w,
              ),
              Gap(AppSize.s16.h),
              Text(
                title,
                style: getBoldTextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: FontSizeManager.s22.sp,
                ),
              ),
              if (description != null && description.isNotEmpty) ...[
                Gap(AppSize.s4.h),
                Text(
                  description,
                  style: getMediumTextStyle(
                    color: ColorManager.greyColor,
                    fontSize: FontSizeManager.s16.sp,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
