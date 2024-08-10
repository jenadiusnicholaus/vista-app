import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../shared/error_handler.dart';
import '../../../auth/user_profile/models.dart';
import '../../repository.dart';

part 'my_rosters_event.dart';
part 'my_rosters_state.dart';

class MyRostersBloc extends Bloc<MyRostersEvent, MyRostersState> {
  final EjabberdApiRepository ejabberdApiRepository;
  MyRostersBloc({required this.ejabberdApiRepository})
      : super(MyRostersInitial()) {
    on<MyRostersEvent>((event, emit) {});
    on<GetMyRosters>((event, emit) async {
      emit(MyRostersLoading());
      try {
        List<UserProfileModel> myRosters = await ejabberdApiRepository
            .fetchMyRoster(username: event.username, host: event.host);
        emit(MyRostersLoaded(myRosters));
      } catch (e, s) {
        print(s);
        String errorMessage = ExceptionHandler.handleError(e);
        emit(MyRostersError(errorMessage));
      }
    });
  }
}
