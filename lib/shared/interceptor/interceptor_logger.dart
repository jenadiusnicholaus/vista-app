import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('Request to ${options.method} ${options.uri}');
    // Optionally log headers, body, etc.
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('Response from ${response.requestOptions.method} ${response.requestOptions.uri}: ${response.statusCode}');
    // Optionally log headers, body, etc.
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('Error in ${err.requestOptions.method} ${err.requestOptions.uri}: ${err.message}');
    // Optionally log error details, response, etc.
    super.onError(err, handler);
  }
}
