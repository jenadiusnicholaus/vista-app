import '../../../shared/api_call/api.dart';
import '../../../shared/environment.dart';

class ActivateAccountRepository {
  final DioApiCall apiCall;
  final Environment environment;
  ActivateAccountRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<dynamic> verifyEmail({String? otpCode, String? email}) async {
    var data = {"email": email, "otp": otpCode};

    var response = await apiCall.post(
      environment.getBaseUrl + environment.VERIFY_EMAI_URL,
      data: data,
    );
    if (response.statusCode == 200) {
      return response.data;
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

  Future<dynamic> resendOTP({String? email}) async {
    var response = await apiCall.post(
      environment.getBaseUrl + environment.RESEND_OTP_URL,
      data: {
        "email": email,
      },
    );
    if (response.statusCode == 200) {
      return response.data;
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
