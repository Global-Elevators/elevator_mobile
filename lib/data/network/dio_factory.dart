import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String LANGUAGE = "language";

// class DioFactory {
//   final AppPreferences _appPreferences;
//   Future<void>? _refreshFuture;
//
//   DioFactory(this._appPreferences);
//
//   // ========================
//   // 🔧 Public API
//   // ========================
//   Future<Dio> getDio() async {
//     final dio = Dio(_buildBaseOptions());
//     dio.interceptors.add(_buildAuthInterceptor(dio));
//
//     if (!kReleaseMode) dio.interceptors.add(_buildLogger());
//
//     return dio;
//   }
//
//   // ========================
//   // ⚙️ Base Configuration
//   // ========================
//   BaseOptions _buildBaseOptions() {
//     return BaseOptions(
//       baseUrl: dotenv.env['BASE_URL']!,
//       headers: {
//         ACCEPT: APPLICATION_JSON,
//         CONTENT_TYPE: APPLICATION_JSON,
//       },
//       receiveDataWhenStatusError: true,
//       sendTimeout: const Duration(seconds: Constants.timeout),
//       receiveTimeout: const Duration(seconds: Constants.timeout),
//       validateStatus: (status) => status != null && status < 500,
//     );
//   }
//
//   // ========================
//   // 🧩 Interceptors
//   // ========================
//   InterceptorsWrapper _buildAuthInterceptor(Dio dio) {
//     return InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         await _attachAccessToken(options);
//         return handler.next(options); //it is a method that is called when a
//         // request is made
//       },
//       onError: (err, handler) async {
//         await _handleAuthError(err, handler, dio);
//       },
//     );
//   }
//
//   PrettyDioLogger _buildLogger() {
//     return PrettyDioLogger(
//       requestHeader: true,
//       requestBody: true,
//       responseHeader: true,
//       responseBody: true,
//     );
//   }
//
//   // ========================
//   // 🔑 Token Management
//   // ========================
//
//   Future<void> _attachAccessToken(RequestOptions options) async {
//     try {
//       final token = await _appPreferences.getUserToken('login');
//       final tokenType = await _appPreferences.getUserToken('tokenType');
//
//       if (token.isNotEmpty) {
//         options.headers['Authorization'] = '$tokenType $token';
//       } else {
//         options.headers.remove('Authorization');
//       }
//     } catch (e) {
//       debugPrint('⚠️ Failed to read token: $e');
//     }
//   }
//
//   Future<void> _handleAuthError(
//       DioException err,
//       ErrorInterceptorHandler handler,
//       Dio dio,
//       ) async {
//     final statusCode = err.response?.statusCode;
//     final requestOptions = err.requestOptions;
//     final alreadyRetried = requestOptions.extra['retried'] == true; // it is a
//     // flag that is set to true when a request is retried
//
//     // Only refresh on unauthorized and non-retried requests
//     if (statusCode == 401 && !alreadyRetried) {
//       await _tryTokenRefreshAndRetry(err, handler, dio);
//       return;
//     }
//
//     // Forward other errors
//     handler.next(err);
//   }
//
//   Future<void> _tryTokenRefreshAndRetry(
//       DioException err,
//       ErrorInterceptorHandler handler,
//       Dio dio,
//       ) async {
//     try {
//       // Ensure refresh process is not duplicated concurrently
//       _refreshFuture ??= _performRefresh(dio.options.baseUrl);
//       await _refreshFuture;
//       _refreshFuture = null;
//
//       final newAccess = await _appPreferences.getUserToken('login');
//       final newTokenType = await _appPreferences.getUserToken('tokenType');
//
//       if (newAccess.isEmpty) {
//         return handler.next(err);
//       }
//
//       final response = await _retryRequestWithNewToken(
//         dio,
//         err.requestOptions,
//         newAccess,
//         newTokenType,
//       );
//
//       return handler.resolve(response);
//     } catch (refreshErr) {
//       await _clearTokensOnRefreshFailure();
//       _refreshFuture = null;
//       handler.next(err);
//     }
//   }
//
//   Future<Response<dynamic>> _retryRequestWithNewToken(
//       Dio dio,
//       RequestOptions requestOptions,
//       String token,
//       String tokenType,
//       ) async {
//     final newOptions = requestOptions.copyWith(
//       headers: {
//         ...requestOptions.headers,
//         'Authorization': '$tokenType $token',
//       },
//       extra: {
//         ...requestOptions.extra,
//         'retried': true,
//       },
//     );
//
//     return dio.fetch(newOptions);
//   }
//
//   Future<void> _clearTokensOnRefreshFailure() async {
//     try {
//       await _appPreferences.logOut('login');
//       await _appPreferences.logOut('tokenType');
//       await _appPreferences.logOut('refresh');
//       debugPrint('🔒 Tokens cleared after refresh failure');
//     } catch (e) {
//       debugPrint('⚠️ Error clearing tokens: $e');
//     }
//   }
//
//   // ========================
//   // 🔄 Token Refresh Logic
//   // ========================
//   Future<void> _performRefresh(String baseUrl) async {
//     final refreshToken = await _appPreferences.getUserToken('refresh');
//     if (refreshToken.isEmpty) {
//       throw Exception('No refresh token available');
//     }
//
//     final refreshDio = Dio(BaseOptions(baseUrl: baseUrl));
//
//     try {
//       final response = await refreshDio.post(
//         '/auth/refresh',
//         data: {'refresh_token': refreshToken},
//         options: Options(contentType: Headers.jsonContentType),
//       );
//
//       final data = response.data;
//       final parsed = _parseRefreshResponse(data);
//
//       if (parsed.accessToken == null || parsed.accessToken!.isEmpty) {
//         throw Exception('Refresh response did not contain an access token');
//       }
//
//       await _saveNewTokens(parsed);
//       debugPrint('✅ Token refresh succeeded');
//     } catch (e) {
//       debugPrint('❌ Token refresh failed: $e');
//       rethrow;
//     }
//   }
//
//   // ========================
//   // 🧩 Token Parsing & Storage
//   // ========================
//   _ParsedTokenData _parseRefreshResponse(dynamic data) {
//     if (data is! Map<String, dynamic>) return _ParsedTokenData.empty();
//
//     Map<String, dynamic> source = data;
//     if (data['data'] is Map<String, dynamic>) {
//       source = data['data'] as Map<String, dynamic>;
//     }
//
//     return _ParsedTokenData(
//       accessToken: source['access_token'] ?? source['token'],
//       refreshToken: source['refresh_token'],
//       tokenType: source['token_type'] ?? 'Bearer',
//     );
//   }
//
//   Future<void> _saveNewTokens(_ParsedTokenData tokenData) async {
//     await _appPreferences.setUserToken('login', tokenData.accessToken ?? '');
//     await _appPreferences.setUserToken('tokenType', tokenData.tokenType);
//     if (tokenData.refreshToken?.isNotEmpty ?? false) {
//       await _appPreferences.setUserToken('refresh', tokenData.refreshToken!);
//     }
//   }
// }

// ========================
// 🧩 Helper Data Class
// ========================
// class _ParsedTokenData {
//   final String? accessToken;
//   final String? refreshToken;
//   final String tokenType;
//
//   const _ParsedTokenData({
//     this.accessToken,
//     this.refreshToken,
//     required this.tokenType,
//   });
//
//   factory _ParsedTokenData.empty() =>
//       const _ParsedTokenData(accessToken: '', refreshToken: '', tokenType: 'Bearer');
// }

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    final options = BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
      headers: {
        ACCEPT: APPLICATION_JSON,
        CONTENT_TYPE: APPLICATION_JSON,
        // LANGUAGE: language,
      },
      receiveDataWhenStatusError: true,
      sendTimeout: const Duration(seconds: Constants.timeout),
      receiveTimeout: const Duration(seconds: Constants.timeout),
      validateStatus: (status) => status != null && status < 500,
    );

    final dio = Dio(options);

    // Interceptor: attach Authorization header dynamically per request
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token = await _appPreferences.getUserToken("login");
            final tokenType = await _appPreferences.getUserToken("tokenType");
            if (token.isNotEmpty) {
              options.headers["Authorization"] = "$tokenType $token";
            } else {
              // ensure header is not left from previous request
              options.headers.remove("Authorization");
            }
          } catch (e) {
            // safe fallback: do not block the request, but log
            debugPrint("Failed to read token in interceptor: $e");
          }
          return handler.next(options);
        },
        onError: (DioError err, handler) {
          // Optional: handle 401 here globally (refresh token, logout, etc.)
          return handler.next(err);
        },
      ),
    );

    // logging only in debug
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
    }
    return dio;
  }
}


/*
sendTimeout:  Maximum time Dio waits while sending data to the server.
receiveTimeout: Maximum time Dio waits to receive a response after sending a request.
*/
