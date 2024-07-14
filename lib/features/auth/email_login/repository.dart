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
    } else if (response.statusCode == 400) {
      if (response.data['error'] != null) {
        throw Exception(response.data['error']);
      } else if (response.data['message'] != null) {
        throw Exception(response.data['message']);
      } else if (response.data['detail'] != null) {
        throw Exception(response.data['detail']);
      }
      throw Exception(response.data);
    }
  }
}
