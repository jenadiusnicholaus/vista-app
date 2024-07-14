part of 'confirm_reset_password_bloc.dart';

@immutable
sealed class ConfirmResetPasswordState {}

final class ConfirmResetPasswordInitial extends ConfirmResetPasswordState {}

final class ConfirmResetPasswordLoading extends ConfirmResetPasswordState {}

final class ConfirmResetPasswordSuccess extends ConfirmResetPasswordState {
  final dynamic response;
  ConfirmResetPasswordSuccess({required this.response});
}

final class ConfirmResetPasswordFailure extends ConfirmResetPasswordState {
  final String error;
  ConfirmResetPasswordFailure(this.error);
}
