import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vista/features/auth/user_profile/models.dart';
import 'package:vista/features/auth/user_profile/repository.dart';

import '../../../../shared/error_handler.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileRepository userProfileRepository;
  UserProfileBloc({required this.userProfileRepository})
      : super(UserProfileInitial()) {
    on<GetUserProfileEvent>((event, emit) async {
      emit(UserProfileLoading());
      try {
        UserProfileModel userProfileModel =
            await userProfileRepository.getUserProfile();
        emit(UserProfileLoaded(userProfileModel));
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);
        emit(UserProfileError(errorMessage));
      }
    });

    // on<UpdateUserProfileEvent>((event, emit) async {
    //   emit(UserProfileLoading());
    //   try {
    //     await userProfileRepository.updateUserProfile(event.userProfileModel);
    //     emit(UserProfileLoaded(event.userProfileModel));
    //   } catch (e) {
    //     emit(UserProfileError(e.toString()));
    //   }
    // });
  }
}
