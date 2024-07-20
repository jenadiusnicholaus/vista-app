import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vista/features/auth/user_profile/models.dart';
import 'package:vista/features/auth/user_profile/repository.dart';

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
        emit(UserProfileError("Error fetching user profile"));
      }
    });
  }
}
