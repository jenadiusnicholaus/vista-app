import 'package:vista/shared/api_call/api.dart';
import 'package:vista/shared/environment.dart';

import '../../features/auth/user_profile/bloc/user_profile_bloc.dart';
import '../../features/fcm/repository.dart';

Future<void> notify(state, context) async {
  await FcmRepository(
    apiCall: DioApiCall(),
    environment: Environment.instance,
  ).sendNotification(
      title: "One More booking ",
      body: state is UserProfileLoaded
          ? "One more booking for ${state.userProfileModel.firstName}"
          : "Booking confirmed",
      token: state.property.host.fcmtoken.fcmToken,
      senderId:
          state is UserProfileLoaded ? state.userProfileModel.phoneNumber : '',
      senderTimeStamp: DateTime.now().millisecondsSinceEpoch.toString());
}
