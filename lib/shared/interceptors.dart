import 'package:dio/dio.dart';
import 'package:vista/shared/environment.dart';
import 'dart:convert';

import 'utils/local_storage.dart';

class TokenInterceptor extends Interceptor {
  Dio dio;
  String token;
  Environment environment = Environment.instance;

  TokenInterceptor({required this.dio, required this.token});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    List<String> ignoreSubUrls = [
      'authentication/',

      // Add more substrings to ignore here
    ];

    // Flag to indicate if the current URL should be ignored
    bool shouldIgnore =
        ignoreSubUrls.any((subUrl) => options.uri.toString().contains(subUrl));

    if (!shouldIgnore) {
      // If URL does not contain any ignore substrings, add the token to the request
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Continue with the request
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // If the request was unauthorized (e.g., token expired)
    if (err.response?.statusCode == 401) {
      try {
        // Attempt to refresh the token
        Response response = await refreshToken();
        if (response.statusCode == 200) {
          // If token refresh is successful, update the token
          token = response.data['access'];
          // Retry the original request with the new token
          final opts = Options(
            method: err.requestOptions.method,
            headers: {"Authorization": "Bearer $token"},
          );
          final clonedRequest = await dio.request(
            err.requestOptions.path,
            options: opts,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );
          // Return the result of the retried request
          return handler.resolve(clonedRequest);
        }
      } catch (e) {
        // If token refresh fails, continue with the original error
        return handler.next(err);
      }
    }
    // For other errors, just pass them along
    super.onError(err, handler);
  }

  Future<Response<dynamic>> refreshToken() async {
    // Implement token refresh logic here, e.g., make a request to the refresh token endpoint
    // This is a placeholder implementation
    var headers = {'Content-Type': 'application/json'};
    var refreshToken = await LocalStorage.read(key: 'refresh_token');
    var data = json.encode({
      "refresh": refreshToken,
    });
    var dio = Dio();
    var response = await dio.request(
      environment.getBaseUrl + environment.REFRESH_TOKEN,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      LocalStorage.write(key: 'access_token', value: response.data['access']);
      return response;
    } else {
      throw Exception('Failed to refresh token');
    }
  }
}
