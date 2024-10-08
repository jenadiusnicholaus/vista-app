import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:vista/features/auth/email_login/email_login.dart';
import 'package:vista/features/auth/email_login/models.dart';
import 'package:vista/features/auth/email_login/repository.dart';
import 'package:vista/shared/utils/local_storage.dart';

import '../../../../shared/error_handler.dart';
import '../../user_profile/bloc/user_profile_bloc.dart';

part 'email_login_event.dart';
part 'email_login_state.dart';

class EmailLoginBloc extends Bloc<EmailLoginEvent, EmailLoginState> {
  final EmailLoginRepository? emailLoginRepository;
  final UserProfileBloc? userProfileBloc;
  EmailLoginBloc({this.emailLoginRepository, required this.userProfileBloc})
      : super(EmailLoginInitial()) {
    on<EmailLoginButtonPressed>((event, emit) async {
      // Delay
      emit(EmailLoginLoading());
      await Future.delayed(const Duration(seconds: 5));
      try {
        LoginModel loginModel = await emailLoginRepository!.emailLogin(
          email: event.email,
          password: event.password,
        );
        LocalStorage.write(key: "access_token", value: loginModel.access!);
        LocalStorage.write(key: "refresh_token", value: loginModel.refresh!);
        userProfileBloc!.add(GetUserProfileEvent());
        emit(EmailLoginSuccess(userModel: loginModel));

        Get.offAndToNamed("/home");
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);

        emit(EmailLoginFailure(errorMessage));
      }
    });

    on<LogoutUserEvent>((event, emit) async {
      // Delay
      emit(LogoutLoading());
      await Future.delayed(const Duration(seconds: 5));

      try {
        var res = await emailLoginRepository!.logoutUser(
          refreshToken: event.refreshToken,
        );
        if (res != null) {
          LocalStorage.deleteAll();
        }

        emit(LogoutSuccess(
            "You have been successfully logged out. Please login to continue."));
        Get.to(() => const EmailLogin());
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);

        emit(LogoutFailure(errorMessage));
      }
    });
  }
}
