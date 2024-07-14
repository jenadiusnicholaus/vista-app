import 'package:vista/features/auth/email_login/models.dart';
import 'package:vista/shared/environment.dart';

import '../../../shared/api_call/api.dart';
import 'models.dart';

class PhoneNumberRepository {
  final DioApiCall apiCall;
  final Environment environment;
  PhoneNumberRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<SentTokenModel> sendPhoneNumberVerOTP(String phoneNumber) async {
    var response = await apiCall.post(
      environment.getBaseUrl + environment.PHONE_NUMBER_AUTH,
      data: {
        "phone_number": phoneNumber,
      },
    );
    if (response.statusCode == 200) {
      SentTokenModel sentTokenModel = SentTokenModel.fromJson(response.data);
      return sentTokenModel;
    } else {
      throw Exception(response.data);
    }
  }

  Future<LoginModel> verifyPhoneNumberOTP(
      {String? otpCode, String? phoneNumber}) async {
    var response = await apiCall.post(
      environment.getBaseUrl + environment.PHONE_NUMBER_VERIFY,
      data: {
        "phone_number": phoneNumber,
        "otp": otpCode,
      },
    );
    if (response.statusCode == 200) {
      LoginModel loginModel = LoginModel.fromJson(response.data);
      return loginModel;
    } else {
      throw Exception(response.data);
    }
  }
}
