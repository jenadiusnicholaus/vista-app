import 'package:vista/features/auth/email_login/models.dart';

import '../../../shared/api_call/api.dart';
import '../../../shared/environment.dart';

class EmailLoginRepository {
  final DioApiCall apiCall;
  final Environment environment;
  EmailLoginRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<dynamic> emailLogin({String? email, String? password}) async {
    var data = {"email": email, "password": password};

    var response = await apiCall.post(
      environment.getBaseUrl + environment.LOGIN_URL,
      data: data,
    );
    if (response.statusCode == 200) {
      LoginModel loginModel = LoginModel.fromJson(response.data);
      return loginModel;
    } else {
      throw Exception(response.data);
    }
  }

  // logout user

  Future<dynamic> logoutUser({required String? refreshToken}) async {
    var response = await apiCall.post(
      environment.getBaseUrl + environment.LOGOUT_URL,
      data: {"refresh": refreshToken},
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception(response.data);
    }
  }
}
