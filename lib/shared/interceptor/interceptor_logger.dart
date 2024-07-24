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
    log('Request uri: ${options.uri}');
    log('Request method: ${options.method}');
    log('Request path: ${options.path}');
    log('Request baseUrl: ${options.baseUrl}');

    // Optionally log headers, body, etc.
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('Response from ${response.requestOptions.method} ${response.requestOptions.uri}: ${response.statusCode}');
    log('Response data: ${response.data}');
    log('Response headers: ${response.headers}');
    log('Response status message: ${response.statusMessage}');
    log('Response status code: ${response.statusCode}');
    log('Response request: ${response.requestOptions}');
    log('Response request data: ${response.requestOptions.data}');
    log('Response request headers: ${response.requestOptions.headers}');
    log('Response request query parameters: ${response.requestOptions.queryParameters}');
    log('Response request uri: ${response.requestOptions.uri}');
    log('Response request method: ${response.requestOptions.method}');
    log('Response request path: ${response.requestOptions.path}');
    log('Response request baseUrl: ${response.requestOptions.baseUrl}');

    // Optionally log response, headers, etc.

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('Error in ${err.requestOptions.method} ${err.requestOptions.uri}: ${err.message}');
    log('Error response: ${err.response}');
    log('Error response data: ${err.response?.data}');
    log('Error response headers: ${err.response?.headers}');
    log('Error response status code: ${err.response?.statusCode}');
    log('Error response status message: ${err.response?.statusMessage}');

    // Optionally log error details, response, etc.
    if (err.response!.statusCode != 401) {
      ExceptionHandler.handleError(err);
    }
    super.onError(err, handler);
  }
}
