import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models.dart';
import '../repository.dart';

part 'my_booking_request_event.dart';
part 'my_booking_request_state.dart';

class MyBookingRequestBloc
    extends Bloc<MyBookingRequestEvent, MyBookingRequestState> {
  final GuestBookingRequestsRepository repository;
  MyBookingRequestBloc({required this.repository})
      : super(MyBookingRequestInitial()) {
    // on<MyBookingRequestEvent>((event, emit) async {
    //   if (event is MyBookingRequestEventGetBookingRequests) {
    //     emit(MyBookingRequestLoading());
    //     try {
    //       final myBookingRequests = await repository.getGuestBookingRequests();
    //       if (myBookingRequests.isEmpty) {
    //         emit(MyBookingRequestEmpty());
    //       } else {
    //         emit(MyBookingRequestLoaded(myBookingRequests));
    //       }
    //     } catch (e) {
    //       emit(MyBookingRequestError('Failed to load booking requests'));
    //     }
    //   }
    // });
  }
}
