import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:vista/features/auth/activate_account/repository.dart';
import 'package:vista/features/auth/email_login/email_login.dart';

import '../../../../shared/error_handler.dart';

part 'activate_account_event.dart';
part 'activate_account_state.dart';

class ActivateAccountBloc
    extends Bloc<ActivateAccountEvent, ActivateAccountState> {
  final ActivateAccountRepository activateAccountRepository;
  ActivateAccountBloc({
    required this.activateAccountRepository,
  }) : super(ActivateAccountInitial()) {
    on<ActivateAccountEvent>((event, emit) {
    });

    on<VerifyEmailEvent>((event, emit) async {
      // Delay
      emit(ActivateAccountLoading());
      await Future.delayed(const Duration(seconds: 5));

      try {
        // Call the API to verify the email
        var response = await activateAccountRepository.verifyEmail(
          email: event.email,
          otpCode: event.code,
        );
        emit(ActivateAccountSuccess('Email verified successfully'));
        if (response != null) {
          // Navigate to the next page
          Get.to(() => const EmailLogin());
        }
      } catch (e) {
        var errorMessage = ExceptionHandler.handleError(e);
        Get.snackbar('Error', errorMessage,
            snackPosition: SnackPosition.TOP,
            icon: const Icon(Icons.error, color: Colors.red));
        emit(ResendCodeFailure(errorMessage));
        ;
      }
    });

    on<ResendCodeEvent>((event, emit) async {
      // Delay
      emit(ActivateAccountLoading());
      await Future.delayed(const Duration(seconds: 5));

      try {
        // Call the API to resend the code
        await activateAccountRepository.resendOTP(
          email: event.email,
        );
        emit(ActivateAccountSuccess('Code resent successfully'));
      } catch (e) {
        var errorMessage = ExceptionHandler.handleError(e);
        Get.snackbar('Error', errorMessage,
            snackPosition: SnackPosition.TOP,
            icon: const Icon(Icons.error, color: Colors.red));

        emit(ResendCodeFailure(errorMessage));
      }
    });
  }
}
