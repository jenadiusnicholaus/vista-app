part of 'booking_bloc.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class GetBookingLoading extends BookingState {}

final class GetBookingLoaded extends BookingState {
  final MyBookingModel booking;

  GetBookingLoaded(this.booking);
}

final class GetBookingFailed extends BookingState {
  final dynamic error;

  GetBookingFailed(this.error);
}

final class AddingBookinngInforsLoading extends BookingState {}

final class AddBookingSuccess extends BookingState {}

final class AddBookingFailed extends BookingState {}

// update

final class UpdateBookingInfosLoading extends BookingState {}

final class UpdateBookingInfosSuccess extends BookingState {}

final class UpdateBookingInfosFailed extends BookingState {
  final dynamic error;

  UpdateBookingInfosFailed(this.error);
}
