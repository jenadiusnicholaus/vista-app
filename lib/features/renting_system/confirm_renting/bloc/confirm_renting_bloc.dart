import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../shared/error_handler.dart';
import '../../repository.dart';

part 'confirm_renting_event.dart';
part 'confirm_renting_state.dart';

class ConfirmRentingBloc
    extends Bloc<ConfirmRentingEvent, ConfirmRentingState> {
  RentingRepository rentingRepository;
  ConfirmRentingBloc({required this.rentingRepository})
      : super(ConfirmRentingInitial()) {
    on<ConfirmRentingEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ConfirmRenting>((event, emit) async {
      emit(ConfirmRentingLoading());
      try {
        dynamic res = await rentingRepository.confirmRenting(
          rentingId: event.rentingId,
          amount: event.amount,
          accountNumber: event.accountNumber,
          paymentMethod: event.paymentMethod,
        );
        emit(ConfirmRentingSuccess(res['message']));
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);
        emit(ConfirmRentingFailed(errorMessage));
      }
    });
  }
}
