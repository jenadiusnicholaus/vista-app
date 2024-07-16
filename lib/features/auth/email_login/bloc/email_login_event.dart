part of 'email_login_bloc.dart';

@immutable
sealed class EmailLoginEvent {}

final class EmailLoginButtonPressed extends EmailLoginEvent {
  final String email;
  final String password;

  EmailLoginButtonPressed({required this.email, required this.password});
}

// logout user
final class LogoutUserEvent extends EmailLoginEvent {
  final String? refreshToken;
  LogoutUserEvent({this.refreshToken});
}
