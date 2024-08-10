import '../../shared/api_call/api.dart';
import '../../shared/environment.dart';
import '../auth/user_profile/models.dart';

class EjabberdApiRepository {
  final DioApiCall apiCall;
  final Environment environment;
  EjabberdApiRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<List<UserProfileModel>> fetchMyRoster(
      {required String username, required String host}) async {
    var data = {"user": username, "host": host};
    var response = await apiCall
        .post(environment.getBaseUrl + environment.MY_ROSTER, data: data);

    if (response.statusCode == 200) {
      var rosters = response.data as List;

      List<UserProfileModel> myRosters =
          rosters.map((e) => UserProfileModel.fromJson(e)).toList();

      return myRosters;
    } else {
      throw Exception('Failed to load Rosters');
    }
  }
}
