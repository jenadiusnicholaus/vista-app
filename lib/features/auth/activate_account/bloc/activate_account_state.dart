part of 'activate_account_bloc.dart';

@immutable
sealed class ActivateAccountState {}

final class ActivateAccountInitial extends ActivateAccountState {}

final class ActivateAccountLoading extends ActivateAccountState {}

final class ActivateAccountSuccess extends ActivateAccountState {
  final String message;
  ActivateAccountSuccess(this.message);
}

final class ActivateAccountFailure extends ActivateAccountState {
  final String? message;
  ActivateAccountFailure({required this.message});
}

final class ResendCodeLoading extends ActivateAccountState {}

class ResendCodeSuccess extends ActivateAccountState {
  final String message;
  ResendCodeSuccess(this.message);
}

class ResendCodeFailure extends ActivateAccountState {
  final String? message;
  ResendCodeFailure(this.message);
}
