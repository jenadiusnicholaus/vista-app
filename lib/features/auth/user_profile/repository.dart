import '../../../data/sample_data.dart';
import '../../../shared/api_call/api.dart';
import '../../../shared/environment.dart';
import 'models.dart';

class UserProfileRepository {
  final DioApiCall apiCall;
  final Environment environment;
  UserProfileRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<UserProfileModel> getUserProfile() async {
    var response =
        await apiCall.get(environment.getBaseUrl + environment.USER_PROFILE);
    if (response.statusCode == 200) {
      UserProfileModel userProfileModel =
          UserProfileModel.fromJson(response.data);
      return userProfileModel;
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {}
}
