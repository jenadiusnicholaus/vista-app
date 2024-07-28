import 'package:get/get.dart';
import 'package:vista/features/auth/email_login/email_login.dart';
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
      Get.offAll(() => const EmailLogin());
      throw Exception('Refresh token is expired');
    }

    if (refreshToken == null) {
      Get.offAll(() => const EmailLogin());
      throw Exception('Refresh token is expired');
    }

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
      throw Exception('Failed to refresh token');
    }
  }
}
