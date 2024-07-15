import '../../../shared/api_call/api.dart';
import '../../../shared/environment.dart';
import 'models.dart';

class ForgetPasswordRepository {
  final DioApiCall apiCall;
  final Environment environment;
  ForgetPasswordRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<dynamic> sendPasswordResetEmail(String email) async {
    var data = {"email": email};

    var response = await apiCall.post(
      environment.getBaseUrl + environment.FORGET_PASSWORD_URL,
      data: data,
    );
    if (response.statusCode == 200) {
      ForgetPasswordModel forgetPasswordModel =
          ForgetPasswordModel.fromJson(response.data);

      return forgetPasswordModel;
    } else {
      throw Exception(response.data);
    }
  }
}
