part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

class GetUserProfileEvent extends UserProfileEvent {}

class UpdateUserProfileEvent extends UserProfileEvent {
  final UserProfileModel userProfileModel;

  UpdateUserProfileEvent(this.userProfileModel);
}
