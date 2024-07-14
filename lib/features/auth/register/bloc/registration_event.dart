part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

final class RegistrationEventInitial extends RegistrationEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String dateOfBirth;
  final String password;
  final String password2;
  final bool agreedToTerms;

  RegistrationEventInitial(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.password,
      required this.password2,
      required this.agreedToTerms});
}
