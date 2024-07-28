part of 'confirm_booking_bloc.dart';

@immutable
sealed class ConfirmBookingEvent {}

final class ConfirmBooking extends ConfirmBookingEvent {
  final int? bookingId;
  final String? paymentMethod;
  final String? accountNumber;
  final String? amount;

  ConfirmBooking({
    required this.bookingId,
    required this.paymentMethod,
    required this.accountNumber,
    required this.amount,
  });
}
