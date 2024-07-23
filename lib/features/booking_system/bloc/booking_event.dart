part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}

class GetMyBooking extends BookingEvent {}

class AddBooking extends BookingEvent {
  final dynamic property;
  final dynamic checkIn;
  final dynamic checkOut;
  final dynamic adults;
  final dynamic children;
  AddBooking(
      {this.property, this.checkIn, this.checkOut, this.adults, this.children});
}

class UpdateBookingInfos extends BookingEvent {
  final dynamic bookingId;
  final dynamic checkIn;
  final dynamic checkOut;
  final dynamic adults;
  final dynamic children;
  final dynamic totalPrice;
  final dynamic property;
  UpdateBookingInfos(
      {required this.bookingId,
      this.checkIn,
      this.checkOut,
      this.adults,
      this.children,
      required this.totalPrice,
      this.property});
}
