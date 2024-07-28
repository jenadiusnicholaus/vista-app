part of 'confirm_booking_bloc.dart';

@immutable
sealed class ConfirmBookingState {}

final class ConfirmBookingInitial extends ConfirmBookingState {}

final class ConfirmBookingLoading extends ConfirmBookingState {
  final String message;

  ConfirmBookingLoading(this.message);
}

final class ConfirmBookingSuccess extends ConfirmBookingState {}

final class ConfirmBookingFailure extends ConfirmBookingState {
  final String message;

  ConfirmBookingFailure(this.message);
}
