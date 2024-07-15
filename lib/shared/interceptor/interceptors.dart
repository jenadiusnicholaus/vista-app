import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vista/shared/environment.dart';
import 'package:vista/shared/utils/local_storage.dart';

class TokensInterceptors extends Interceptor {
  Environment environment = Environment.instance;
  Dio dio = Dio(BaseOptions(baseUrl: Environment.instance.getBaseUrl));
  String? token;
  TokensInterceptors();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Ideally, token should be fetched from a secure storage or state management solution
    token = await getTokenFromStorage();

    List<String> ignoreSubUrls = [
      'authentication/',
    ];

    // Flag to indicate if the current URL should be ignored
    bool shouldIgnore =
        ignoreSubUrls.any((subUrl) => options.uri.toString().contains(subUrl));
    log('Request to $shouldIgnore => ${options.uri}');
    if (token != null) {
      if (!shouldIgnore) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      // options.headers["Authorization"] = "Bearer $token";
    } else {
      options.headers.remove("Authorization");
    }
    options.headers["Content-Type"] = "application/json";
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await refreshToken();
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
        handler.resolve(clonedRequest);
      } catch (e) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
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

  Future<String?> getTokenFromStorage() async {
    return await LocalStorage.read(key: "access_token");
  }
}
