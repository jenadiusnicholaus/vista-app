import '../../../shared/api_call/api.dart';
import '../../../shared/environment.dart';
import '../forget_password/models.dart';

class ConfirmResetPasswordRepository {
  final DioApiCall apiCall;
  final Environment environment;
  ConfirmResetPasswordRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<ForgetPasswordModel> confirmResetPassword(
      {required String email,
      required String newPassword,
      required String confirmPassword,
      required String token}) async {
    var requestData = {
      "email": email,
      "new_password": newPassword,
      "confirm_password": confirmPassword,
      "token": token
    };
    var resposne = await apiCall.post(
      environment.getBaseUrl + environment.CONFIRM_RESET_PASSWORD,
      data: requestData,
    );
    if (resposne.statusCode == 200) {
      ForgetPasswordModel forgetPasswordModel =
          ForgetPasswordModel.fromJson(resposne.data);
      return forgetPasswordModel;
    } else {
      throw Exception(resposne.data);
    }
  }
}
