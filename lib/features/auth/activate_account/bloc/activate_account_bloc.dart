import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:vista/features/auth/activate_account/repository.dart';
import 'package:vista/features/auth/email_login/email_login.dart';

part 'activate_account_event.dart';
part 'activate_account_state.dart';

class ActivateAccountBloc
    extends Bloc<ActivateAccountEvent, ActivateAccountState> {
  final ActivateAccountRepository activateAccountRepository;
  ActivateAccountBloc({
    required this.activateAccountRepository,
  }) : super(ActivateAccountInitial()) {
    on<ActivateAccountEvent>((event, emit) {
      // TODO: implement event handler
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
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());
        emit(ActivateAccountFailure(message: e.toString()));
      }
    });

    //  resend code event
    on<ResendCodeEvent>((event, emit) async {
      // Delay
      emit(ActivateAccountLoading());
      await Future.delayed(const Duration(seconds: 5));

      try {
        // Call the API to resend the code
        var response = await activateAccountRepository.resendOTP(
          email: event.email,
        );
        print(response);
        emit(ActivateAccountSuccess('Code resent successfully'));
      } catch (e) {
        String? errorMessage = 'An unexpected error occurred';

        if (e is DioException) {
          // Check if the error is because of a bad request or other HTTP errors
          if (e.response != null) {
            // Attempt to extract the error message from the response
            errorMessage = e.response?.data['message'] ?? 'An error occurred';
          } else {
            // Error due to sending the request or receiving the response
            errorMessage = e.message;
          }
        }
        emit(ResendCodeFailure( errorMessage));
      }
    });
  }
}
