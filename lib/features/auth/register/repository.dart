import 'package:vista/features/auth/register/models.dart';
import 'package:vista/shared/environment.dart';

import '../../../shared/api_call/api.dart';

class RegistrationRepository {
  final DioApiCall apiCall;
  final Environment environment;
  RegistrationRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<dynamic> userRegistration(
      String email,
      String firstName,
      String lastName,
      String phoneNumber,
      String dateOfBirth,
      String password,
      bool agreedToTerms,
      String password2) async {
    var data = {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber,
      "date_of_birth": dateOfBirth,
      "password": password,
      "password2": password2,
      "agreed_to_Terms": agreedToTerms,
      "user_type": "guest"
    };
    var response = await apiCall.post(
        environment.getBaseUrl + environment.USER_REGISTRATION,
        data: data);
    if (response.statusCode == 201) {
      RegistrationModel registrationModel =
          RegistrationModel.fromJson(response.data);
      return registrationModel;
    } else {
      throw Exception(response.data);
    }
  }
}
