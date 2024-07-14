part of 'email_login_bloc.dart';

@immutable
sealed class EmailLoginState {}

final class EmailLoginInitial extends EmailLoginState {}

final class EmailLoginLoading extends EmailLoginState {}

final class EmailLoginSuccess extends EmailLoginState {
  final LoginModel? userModel;
  EmailLoginSuccess({this.userModel});
}

final class EmailLoginFailure extends EmailLoginState {
  final String message;
  EmailLoginFailure(this.message);
}
