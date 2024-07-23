import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vista/shared/environment.dart';
import 'package:vista/shared/utils/local_storage.dart';

import '../api_call/api.dart';
import '../token_handler.dart';
import 'repository.dart';

class TokensInterceptors extends Interceptor {
  Environment environment = Environment.instance;
  Dio dio = Dio(BaseOptions(baseUrl: Environment.instance.getBaseUrl));
  String? token;
  String? refreshToken;
  bool isTokenExpired = false;
  bool isRefreshTokenExpired = false;

  TokensInterceptors();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Ideally, token should be fetched from a secure storage or state management solution
    token = await getTokenFromStorage();
    // Check if the token is expired before making a request
    // If the token is expired, the request should be intercepted and the token should be
    refreshToken = await getrefreshToken();

    if (token != null) {
      isTokenExpired = TokenHandler.isExpired(token);
    }

    if (refreshToken != null) {
      isRefreshTokenExpired = TokenHandler.isExpired(refreshToken);
    }

    List<String> ignoreSubUrls = ['authentication/'];
    if (refreshToken == null || isRefreshTokenExpired) {
      ignoreSubUrls.add("property/");
    } else {}

    Uri uri = options.uri;
    // Normalize the base URL if necessary, e.g., removing query parameters or fragments
    String path = uri.path; // Directly use the path component of the URI

    // Flag to indicate if the current URL should be ignored
    bool shouldIgnore =
        ignoreSubUrls.any((subUrl) => path.startsWith('/api/v1/$subUrl'));
    log('Request to ignore: $shouldIgnore => ${options.uri}');

    if (token != null && !shouldIgnore) {
      options.headers['Authorization'] = 'Bearer $token';
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
      log('Token expired, refreshing token...');
      try {
        InterceptorRepository repo = InterceptorRepository(
          apiCall: DioApiCall(),
          environment: environment,
        );
        await repo.refreshToken();
        // Fetch the refreshed token

        //  this method retrieves the updated token
        String? refreshedToken = await getTokenFromStorage();
        if (refreshedToken == null) {
          throw Exception("Failed to retrieve refreshed token");
        }

        final opts = Options(
          method: err.requestOptions.method,
          headers: {"Authorization": "Bearer $refreshedToken"},
        );
        final clonedRequest = await dio.request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );
        handler.resolve(clonedRequest);
      } catch (e) {
        log('Failed to refresh token: $e');
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  Future<String?> getTokenFromStorage() async {
    return await LocalStorage.read(key: "access_token");
  }

  Future<String?> getrefreshToken() async {
    return await LocalStorage.read(key: "refresh_token");
  }
}
