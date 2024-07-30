part of 'my_booking_request_bloc.dart';

@immutable
sealed class MyBookingRequestState {}

final class MyBookingRequestInitial extends MyBookingRequestState {}

final class MyBookingRequestLoading extends MyBookingRequestState {}

final class MyBookingRequestLoaded extends MyBookingRequestState {
  final List<MyBookingModel> myBookingRequests;

  MyBookingRequestLoaded(this.myBookingRequests);
}

final class MyBookingRequestError extends MyBookingRequestState {
  final String message;

  MyBookingRequestError(this.message);
}

final class MyBookingRequestEmpty extends MyBookingRequestState {}
