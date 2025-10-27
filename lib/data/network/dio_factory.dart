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
      sendTimeout: const Duration(seconds: Constants.timeout),
      receiveTimeout: const Duration(seconds: Constants.timeout),
      // Dio will treat only 200–399 responses as success and send everything else (like 401, 404, 500) to onError in your InterceptorsWrapper.
      validateStatus: (status) =>
          status != null &&
          status >= 200 &&
          status < 400, // Accept status codes from 200-399
      // validateStatus: (status) => status != null && status < 500,
    );

    final dioInstance = Dio(baseDioOptions);

    // Interceptors
    dioInstance.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
              print("DioFactory onRequest");
              await _addAuthorizationHeaderIfLoggedIn(options);
              handler.next(options);
            },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          print("DioFactory onError");
          if (_isUnauthorizedError(error)) {
            await _handleUnauthorizedError(dioInstance, error, handler);
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

  Future<void> _handleUnauthorizedError(
    Dio dioInstance,
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

/*
sendTimeout:  Maximum time Dio waits while sending data to the server.
receiveTimeout: Maximum time Dio waits to receive a response after sending a request.
*/
