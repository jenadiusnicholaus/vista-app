part of 'activate_account_bloc.dart';

@immutable
sealed class ActivateAccountEvent {}

final class VerifyEmailEvent extends ActivateAccountEvent {
  final String email;
  final String code;

  VerifyEmailEvent({required this.email, required this.code});
}

final class ResendCodeEvent extends ActivateAccountEvent {
  final String email;

  ResendCodeEvent({required this.email});
}
