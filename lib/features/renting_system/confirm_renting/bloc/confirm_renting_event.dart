part of 'confirm_renting_bloc.dart';

@immutable
sealed class ConfirmRentingEvent {}

final class ConfirmRenting extends ConfirmRentingEvent {
  final int? rentingId;
  final String? paymentMethod;
  final String? accountNumber;
  final String? amount;

  ConfirmRenting({
    required this.rentingId,
    required this.paymentMethod,
    required this.accountNumber,
    required this.amount,
  });
}
