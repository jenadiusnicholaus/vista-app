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

  Future<void> sendNotification({
    required String title,
    required String body,
    required String token,
    required senderId,
    required dynamic senderTimeStamp,
    required dynamic toUserid,
  }) async {
    var response = await apiCall.post(
      "${environment.getBaseUrl}${environment.SEND_NOTIFICATION}",
      data: {
        "title": title,
        "body": body,
        "device_registration_token": token,
        "data": {"username": "$senderId", "timestamp": "$senderTimeStamp"},
        "to_user": toUserid,
      },
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.data);
    }
  }
}
