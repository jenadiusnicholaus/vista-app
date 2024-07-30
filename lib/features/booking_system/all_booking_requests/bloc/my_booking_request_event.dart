part of 'my_booking_request_bloc.dart';

@immutable
sealed class MyBookingRequestEvent {}

final class MyBookingRequestEventGetBookingRequests
    extends MyBookingRequestEvent {
  MyBookingRequestEventGetBookingRequests();
}
