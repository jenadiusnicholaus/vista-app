import 'package:vista/shared/api_call/api.dart';
import 'package:vista/shared/environment.dart';

import '../../features/fcm/repository.dart';

Future<void> notify({
  required body,
  required token,
  required userid,
  required toUserid,
  required context,
}) async {
  await FcmRepository(
    apiCall: DioApiCall(),
    environment: Environment.instance,
  ).sendNotification(
      title: "One More booking ",
      body: body,
      token: token,
      senderId: userid,
      senderTimeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
      toUserid: toUserid);
}
