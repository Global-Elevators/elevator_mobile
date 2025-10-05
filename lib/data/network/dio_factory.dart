import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATON_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String LANGUAGE = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    // String language = await _appPreferences.getAppLanguage();

    Map<String, String> header = {
      // CONTENT_TYPE: APPLICATON_JSON,
      ACCEPT: APPLICATON_JSON,
      // AUTHORIZATION: Constants.token,
      // LANGUAGE: language,
    };
    // Write method add 2 numbers

    dio.options = BaseOptions(
      validateStatus: (status) {
        return  status != null && status < 500;
      },
      headers: header,
      receiveDataWhenStatusError: false,
      baseUrl: Constants.baseUrl,
      sendTimeout: const Duration(seconds: Constants.timeout),
      receiveTimeout: const Duration(seconds: Constants.timeout),
    );
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}

/*
sendTimeout: This sets the maximum time Dio will wait while sending data to the server. If the data isn't completely sent within this timeframe, a timeout error occurs.

receiveTimeout: This sets the maximum time Dio will wait to receive a response from the server after a request is sent. If the response isn't fully received within this period, a timeout error occurs.
* */
