part of 'phone_number_auth_bloc.dart';

@immutable
sealed class PhoneNumberAuthState {}

final class PhoneNumberAuthInitial extends PhoneNumberAuthState {}

final class PhoneNumberAuthLoading extends PhoneNumberAuthState {}

final class PhoneNumberAuthSuccess extends PhoneNumberAuthState {
  final SentTokenModel? sentTokenModel;
  final String? phoneNumber;
  PhoneNumberAuthSuccess({this.sentTokenModel, this.phoneNumber});
}

final class PhoneNumberAuthFailure extends PhoneNumberAuthState {
  final String message;
  PhoneNumberAuthFailure(this.message);
}

// verifyPhoneNumberOTP

final class PhoneNumberAuthVerifyLoading extends PhoneNumberAuthState {}

final class PhoneNumberAuthVerifySuccess extends PhoneNumberAuthState {
  final LoginModel? sentTokenModel;
  final String? phoneNumber;
  PhoneNumberAuthVerifySuccess({this.sentTokenModel, this.phoneNumber});
}

final class PhoneNumberAuthVerifyFailure extends PhoneNumberAuthState {
  final String message;
  PhoneNumberAuthVerifyFailure(this.message);
}
