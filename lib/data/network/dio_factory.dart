import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String LANGUAGE = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    final options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: {
        ACCEPT: APPLICATION_JSON,
        // LANGUAGE: language,
      },
      receiveDataWhenStatusError: false,
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
