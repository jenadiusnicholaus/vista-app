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

// create my Bank Account infos

final class AddBankAccountInfosLoading extends UserProfileState {}

final class AddBankAccountInfosSuccess extends UserProfileState {}

final class AddBankAccountInfosFailed extends UserProfileState {
  final dynamic error;

  AddBankAccountInfosFailed(this.error);
}

// update my Bank Account infos

final class UpdateBankAccountInfosLoading extends UserProfileState {}

final class UpdateBankAccountInfosSuccess extends UserProfileState {}

final class UpdateBankAccountInfosFailed extends UserProfileState {
  final dynamic error;

  UpdateBankAccountInfosFailed(this.error);
}

// add my Mobile Money Payment infos

final class AddMobileMoneyPaymentInfosLoading extends UserProfileState {}

final class AddMobileMoneyPaymentInfosSuccess extends UserProfileState {}

final class AddMobileMoneyPaymentInfosFailed extends UserProfileState {
  final dynamic error;

  AddMobileMoneyPaymentInfosFailed(this.error);
}

// update my Mobile Money Payment infos

final class UpdateMobileMoneyPaymentInfosLoading extends UserProfileState {}

final class UpdateMobileMoneyPaymentInfosSuccess extends UserProfileState {}

final class UpdateMobileMoneyPaymentInfosFailed extends UserProfileState {
  final dynamic error;

  UpdateMobileMoneyPaymentInfosFailed(this.error);
}
