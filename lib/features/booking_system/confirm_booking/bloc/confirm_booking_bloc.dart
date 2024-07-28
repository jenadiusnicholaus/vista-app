import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../shared/error_handler.dart';
import '../../repository.dart';

part 'confirm_booking_event.dart';
part 'confirm_booking_state.dart';

class ConfirmBookingBloc
    extends Bloc<ConfirmBookingEvent, ConfirmBookingState> {
  final GuestBookingRepository repository;
  ConfirmBookingBloc({required this.repository})
      : super(ConfirmBookingInitial()) {
    on<ConfirmBookingEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ConfirmBooking>((event, emit) async {
      emit(ConfirmBookingLoading("Loading..."));
      try {
        await repository.confirmBooking(
          bookingId: event.bookingId,
          amount: event.amount,
          accountNumber: event.accountNumber,
          paymentMethod: event.paymentMethod,
        );
        emit(ConfirmBookingSuccess());
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);
        emit(ConfirmBookingFailure(errorMessage));
      }
    });
  }
}
