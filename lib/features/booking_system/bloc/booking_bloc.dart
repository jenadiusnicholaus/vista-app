import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../shared/error_handler.dart';
import '../booking_page.dart';
import '../models.dart';
import '../repository.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GuestBookingRepository guestBookingRepository;

  BookingBloc({required this.guestBookingRepository})
      : super(BookingInitial()) {
    on<BookingEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetMyBooking>((event, emit) async {
      emit(GetBookingLoading());
      try {
        MyBookingModel booking = await guestBookingRepository.getMyBooking();
        emit(GetBookingLoaded(booking));
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);
        log(errorMessage);

        emit(GetBookingFailed(errorMessage));
      }
    });

    on<AddBooking>((event, emit) async {
      emit(GetBookingLoading());
      try {
        await guestBookingRepository.addBooking(
          propertyId: event.property.id,
          checkIn: event.checkIn,
          checkOut: event.checkOut,
          adults: event.adults,
          children: event.children,
          totalPrice: event.property.price,
        );
        emit(AddBookingSuccess());
        Get.off(() => BookingPage(
              property: event.property,
            ));
      } catch (e, s) {
        print(s);
        emit(AddBookingFailed());
      }
    });

    on<UpdateBookingInfos>((event, emit) async {
      emit(UpdateBookingInfosLoading());
      try {
        await guestBookingRepository.updateBookingInfos(
          bookingId: event.bookingId,
          checkIn: event.checkIn,
          checkOut: event.checkOut,
          adults: event.adults,
          children: event.children,
          totalPrice: event.totalPrice,
        );
        emit(UpdateBookingInfosSuccess());
        Get.off(() => BookingPage(
              property: event.property,
            ));
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);
        log(errorMessage);

        emit(UpdateBookingInfosFailed(errorMessage));
      }
    });
  }
}
