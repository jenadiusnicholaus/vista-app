import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:vista/features/auth/email_login/email_login.dart';
import 'package:vista/features/auth/forget_password/models.dart';

import '../confirme_reset_password_page.dart';
import '../repository.dart';

part 'confirm_reset_password_event.dart';
part 'confirm_reset_password_state.dart';

class ConfirmResetPasswordBloc
    extends Bloc<ConfirmResetPasswordEvent, ConfirmResetPasswordState> {
  final ConfirmResetPasswordRepository? confirmResetPasswordRepository;
  ConfirmResetPasswordBloc({this.confirmResetPasswordRepository})
      : super(ConfirmResetPasswordInitial()) {
    on<ConfirmResetPasswordEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnConfirmResetPasswordBtnPressed>((event, emit) async {
      emit(ConfirmResetPasswordLoading());
      try {
        ForgetPasswordModel response = await confirmResetPasswordRepository!
            .confirmResetPassword(
                email: event.email,
                newPassword: event.newPassword,
                confirmPassword: event.confirmPassword,
                token: event.token);
        emit(ConfirmResetPasswordSuccess(response: response));
        Get.to(() => const EmailLogin());
      } catch (e) {
        log(e.toString());
        emit(ConfirmResetPasswordFailure(e.toString()));
      }
    });
  }
}
