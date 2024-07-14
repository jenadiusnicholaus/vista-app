part of 'forget_password_bloc.dart';

@immutable
sealed class ForgetPasswordEvent {}

class OnForgetPasswordBtnPressed extends ForgetPasswordEvent {
  final String email;
  OnForgetPasswordBtnPressed({required this.email});
}
