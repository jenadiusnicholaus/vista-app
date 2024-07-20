import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vista/shared/error_handler.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('Request to ${options.method} ${options.uri}');
    log('Request data: ${options.data}');
    log('Request headers: ${options.headers}');
    log('Request query parameters: ${options.queryParameters}');

    // Optionally log headers, body, etc.
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('Response from ${response.requestOptions.method} ${response.requestOptions.uri}: ${response.statusCode}');
    log('Response data: ${response.data}');
    log('Response headers: ${response.headers}');
    log('Response status message: ${response.statusMessage}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('Error in ${err.requestOptions.method} ${err.requestOptions.uri}: ${err.message}');
    // Optionally log error details, response, etc.
    if (err.response!.statusCode != 401) {
      ExceptionHandler.handleError(err);
    }
    super.onError(err, handler);
  }
}
