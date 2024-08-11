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

  //addd roster
  // {
  //     "localuser": "+255744315516",
  //     "localhost": "192.168.1.181",
  //     "user": "+255788822282",
  //     "host": "192.168.1.181",
  //     "nick": "My Host",
  //     "groups": [],
  //     "subs": ""
  //   };

  Future<void> addRoster({
    required String localuser,
    required String localhost,
    required String user,
    required String host,
    required String nick,
    List<String>? groups,
    String? subs,
  }) async {
    var data = {
      "localuser": localuser,
      "localhost": localhost,
      "user": user,
      "host": host,
      "nick": nick,
      "groups": [],
      "subs": 'both'
    };
    var response = await apiCall
        .post(environment.getBaseUrl + environment.ADD_ROSTER, data: data);

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to add Roster');
    }
  }
}
