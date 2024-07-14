part of 'phone_number_auth_bloc.dart';

@immutable
sealed class PhoneNumberAuthEvent {}

class SendOTPEvent extends PhoneNumberAuthEvent {
  final String? phoneNumber;
  SendOTPEvent({this.phoneNumber});
}

class VerifyOTPEvent extends PhoneNumberAuthEvent {
  final String? otpCode;
  final String? phoneNumber;
  VerifyOTPEvent({this.otpCode, this.phoneNumber});
}
