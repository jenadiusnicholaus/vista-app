import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../../shared/error_handler.dart';
import '../../confirm_reset_password/confirme_reset_password_page.dart';
import '../repository.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordRepository? forgetPasswordRepository;
  ForgetPasswordBloc({this.forgetPasswordRepository})
      : super(ForgetPasswordInitial()) {
    on<ForgetPasswordEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnForgetPasswordBtnPressed>((event, emit) async {
      emit(ForgetPasswordLoading());
      try {
        var response =
            await forgetPasswordRepository!.sendPasswordResetEmail(event.email);
        emit(ForgetPasswordSuccess(
            message: response.message, email: event.email));

        Get.to(() => const ConfirmResetPasswordPage());
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);
        emit(ForgetPasswordFailure(errorMessage));
      }
    });
  }
}
