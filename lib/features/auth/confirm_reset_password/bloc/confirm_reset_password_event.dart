part of 'confirm_reset_password_bloc.dart';

@immutable
sealed class ConfirmResetPasswordEvent {}

class OnConfirmResetPasswordBtnPressed extends ConfirmResetPasswordEvent {
  final String email;
  final String newPassword;

  final String confirmPassword;
  final String token;

  OnConfirmResetPasswordBtnPressed(
      {required this.email,
      required this.newPassword,
      required this.confirmPassword,
      required this.token});
}
