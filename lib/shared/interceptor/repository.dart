import 'package:get/get.dart';
import 'package:vista/features/auth/login_welcome_screen.dart';
import 'package:vista/shared/token_handler.dart';
import '../api_call/api.dart';
import '../environment.dart';
import '../utils/local_storage.dart';

class InterceptorRepository {
  final DioApiCall apiCall;
  final Environment environment;
  InterceptorRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<void> refreshToken() async {
    var refreshToken = await LocalStorage.read(key: 'refresh_token');

    bool isTokenExpired = TokenHandler.isExpired(refreshToken);
    if (isTokenExpired) {
      await _clearTokensAndRedirect();
      throw Exception('Refresh token is expired');
    }

    if (refreshToken == null) {
      await _clearTokensAndRedirect();
      throw Exception('Refresh token is expired');
    }

    try {
      var data = {
        "refresh": refreshToken,
      };
      var response = await apiCall.post(
        environment.getBaseUrl + environment.REFRESH_TOKEN,
        data: data,
      );
      if (response.statusCode == 200) {
        LocalStorage.write(key: 'access_token', value: response.data['access']);
      } else {
        await _clearTokensAndRedirect();
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      await _clearTokensAndRedirect();
      throw Exception('Failed to refresh token: $e');
    }
  }

  Future<void> _clearTokensAndRedirect() async {
    // Clear all stored tokens
    await LocalStorage.delete(key: 'access_token');
    await LocalStorage.delete(key: 'refresh_token');

    // Redirect to welcome page where user can choose login method
    Get.offAll(() => const LoginWelcomeScreen());
  }
}
