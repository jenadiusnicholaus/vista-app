import 'package:vista/features/fcm/model.dart';

import '../../shared/api_call/api.dart';
import '../../shared/environment.dart';

class FcmRepository {
  final DioApiCall apiCall;
  final Environment environment;
  FcmRepository({
    required this.apiCall,
    required this.environment,
  });
  Future<FcmTokenModel> fetchToken() async {
    var response = await apiCall.get(
      "${environment.getBaseUrl}${environment.FCM_TOKEN_URL}",
    );
    if (response.statusCode == 200) {
      return FcmTokenModel.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> saveToken(String token) async {
    var response = await apiCall.post(
        "${environment.getBaseUrl}${environment.FCM_TOKEN_URL}",
        data: {"fcm_token": token});
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.data);
    }
  }

  // UPDATE  TOKEN
  Future<void> updateToken(String token) async {
    var response = await apiCall.patch(
        "${environment.getBaseUrl}${environment.FCM_TOKEN_URL}",
        {"fcm_token": token});
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> sendNotification(String title, String body) async {
    var response = await apiCall.post(
        "${environment.getBaseUrl}${environment.SEND_NOTIFICATION}",
        data: {"title": title, "body": body});
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> sendNotificationToUser(
      String title, String body, String token) async {
    var response = await apiCall.post(
        "${environment.getBaseUrl}${environment.SEND_NOTIFICATION}",
        data: {"title": title, "body": body, "token": token});
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.data);
    }
  }
}
