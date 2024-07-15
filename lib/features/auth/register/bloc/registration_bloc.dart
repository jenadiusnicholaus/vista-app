import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:vista/features/auth/register/models.dart';
import 'package:vista/features/auth/activate_account/verify_email.dart';
import 'package:vista/shared/error_handler.dart';

import '../repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository registrationRepository;

  RegistrationBloc({required this.registrationRepository})
      : super(RegistrationInitial()) {
    on<RegistrationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<RegistrationEventInitial>((event, emit) async {
      // Delay
      emit(RegistrationLoading());
      await Future.delayed(const Duration(seconds: 5));

      try {
        RegistrationModel registrationModel =
            await registrationRepository.userRegistration(
          event.email,
          event.firstName,
          event.lastName,
          event.phoneNumber,
          event.dateOfBirth,
          event.password,
          event.agreedToTerms,
          event.password2,
        );
        emit(RegistrationSuccess(registrationModel: registrationModel));
        Get.to(() => const VerifyEmailPage());
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);
        emit(RegistrationFailure(errorMessage));
      }
    });
  }
}
