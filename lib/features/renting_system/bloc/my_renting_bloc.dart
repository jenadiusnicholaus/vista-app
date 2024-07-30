import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vista/features/renting_system/models.dart';
import 'package:vista/features/renting_system/repository.dart';
import 'package:vista/shared/utils/request_context.dart';

import '../../../constants/consts.dart';
import '../../../shared/error_handler.dart';

part 'my_renting_event.dart';
part 'my_renting_state.dart';

class MyRentingBloc extends Bloc<MyRentingEvent, MyRentingState> {
  final RentingRepository rentingRepository;
  MyRentingBloc({required this.rentingRepository}) : super(MyRentingInitial()) {
    on<MyRentingEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetMyRenting>((event, emit) async {
      emit(MyRentingLoading());
      try {
        MyRentingModel myRentingModel =
            await rentingRepository.getMyRenting(event.propertyId);
        emit(MyRentingSuccess(myRentingModel: myRentingModel));
      } catch (e, s) {
        print(s);
        String errorMessage = ExceptionHandler.handleError(e);

        emit(MyRentingFailure(
          errorMessage: errorMessage,
        ));
      }
    });

    on<AddMyRenting>((event, emit) async {
      emit(AddMyRentingLoading());
      try {
        dynamic response = await rentingRepository.addMyRenting(
          propertyId: event.property.id,
          rentingDurationId: event.rentingDuration,
          totalPrice: event.totalPrice,
          totalFamilyMember: event.totalFamilyMember,
          checkIn: event.checkIn,
          checkOut: event.checkOut,
          adults: event.adults,
          children: event.children,
        );
        emit(AddMyRentingSuccess(message: response["message"]));
        getTheRequestContext(event);
      } catch (e, s) {
        print(e);
        print(s);
        String errorMessage = ExceptionHandler.handleError(e);

        emit(AddMyRentingFailure(
          errorMessage: errorMessage,
        ));
      }
    });

    on<UpdateMyRenting>((event, emit) async {
      emit(AddMyRentingLoading());
      try {
        dynamic response = await rentingRepository.updateRenting(
            propertyId: event.property.id,
            rentingDurationId: event.rentingDuration,
            totalPrice: event.totalPrice,
            totalFamilyMember: event.totalFamilyMember,
            checkIn: event.checkIn,
            checkOut: event.checkOut,
            adults: event.adults,
            children: event.children,
            rentingId: event.rentingId);
        emit(AddMyRentingSuccess(message: response["message"]));
        getTheRequestContext(event);
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);
        emit(AddMyRentingFailure(
          errorMessage: errorMessage,
        ));
      }
    });
  }
}
