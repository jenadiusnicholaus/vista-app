import 'package:dio/dio.dart';

import '../interceptor/interceptor_logger.dart';
import '../interceptor/interceptors.dart';

class DioApiCall {
  Dio dio = Dio();

  DioApiCall() {
    _initializeInterceptors();
  }

  Future<void> _initializeInterceptors() async {
    // Retrieve the current token from local storage or any other secure storage you use
    // String token = await LocalStorage.read(key: 'access_token') ?? '';
    // Add the TokenInterceptor with the current token
    dio.interceptors.add(TokensInterceptors());

    // Add a LoggingInterceptor for logging requests and responses
    dio.interceptors.add(LoggingInterceptor());
  }

  // GET request
  Future<Response> get(String url, {Map<String, dynamic>? headers}) async {
    return dio.get(url, options: Options(headers: headers));
  }

  // POST request
  Future<Response> post(String url,
      {Map<String, dynamic>? data, Map<String, dynamic>? headers}) async {
    return dio.post(url, data: data, options: Options(headers: headers));
  }

  // PUT request
  Future<Response> put(String url, Map<String, dynamic> data,
      {Map<String, dynamic>? headers}) async {
    return dio.put(url, data: data, options: Options(headers: headers));
  }

  // DELETE request
  Future<Response> delete(String url, {Map<String, dynamic>? headers}) async {
    return dio.delete(url, options: Options(headers: headers));
  }

  // PATCH request
  Future<Response> patch(String url, Map<String, dynamic> data,
      {Map<String, dynamic>? headers}) async {
    return dio.patch(url, data: data, options: Options(headers: headers));
  }
}
