part of 'registration_bloc.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationLoading extends RegistrationState {}

final class RegistrationSuccess extends RegistrationState {
  // final String? message;
  final RegistrationModel? registrationModel;
  RegistrationSuccess({this.registrationModel});
}

final class RegistrationFailure extends RegistrationState {
  final String message;
  RegistrationFailure(this.message);
}
