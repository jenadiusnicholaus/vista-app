part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoading extends UserProfileState {}

final class UserProfileLoaded extends UserProfileState {
  final UserProfileModel userProfileModel;

  UserProfileLoaded(this.userProfileModel);
}

final class UserProfileError extends UserProfileState {
  final String error;

  UserProfileError(this.error);
}
