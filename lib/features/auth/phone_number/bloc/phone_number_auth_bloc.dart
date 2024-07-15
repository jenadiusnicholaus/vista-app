import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:vista/features/auth/email_login/models.dart';
import 'package:vista/features/auth/phone_number/verify_phone_number.dart';

import '../../../../home_pages/home.dart';
import '../../../../shared/error_handler.dart';
import '../../../../shared/utils/local_storage.dart';
import '../models.dart';
import '../repository.dart';

part 'phone_number_auth_event.dart';
part 'phone_number_auth_state.dart';

class PhoneNumberAuthBloc
    extends Bloc<PhoneNumberAuthEvent, PhoneNumberAuthState> {
  final PhoneNumberRepository phoneNumberRepository;
  PhoneNumberAuthBloc({required this.phoneNumberRepository})
      : super(PhoneNumberAuthInitial()) {
    on<PhoneNumberAuthEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SendOTPEvent>((event, emit) async {
      // Delay
      emit(PhoneNumberAuthLoading());
      await Future.delayed(const Duration(seconds: 5));

      try {
        SentTokenModel sentTokenModel = await phoneNumberRepository
            .sendPhoneNumberVerOTP(event.phoneNumber!);
        emit(PhoneNumberAuthSuccess(
          sentTokenModel: sentTokenModel,
          phoneNumber: event.phoneNumber,
        ));
        Get.to(() => const VerifyPhone());
      } catch (e) {
        emit(PhoneNumberAuthFailure(e.toString()));
      }
    });

    on<VerifyOTPEvent>((event, emit) async {
      // Delay
      emit(PhoneNumberAuthVerifyLoading());
      await Future.delayed(const Duration(seconds: 5));

      try {
        LoginModel loginModel =
            await phoneNumberRepository.verifyPhoneNumberOTP(
                otpCode: event.otpCode, phoneNumber: event.phoneNumber);
        emit(PhoneNumberAuthVerifySuccess(
          sentTokenModel: loginModel,
          phoneNumber: event.phoneNumber,
        ));
        LocalStorage.write(key: "access_token", value: loginModel.access!);
        LocalStorage.write(key: "refresh_token", value: loginModel.refresh!);
        Get.to(() => const HomePage(title: "vista"));
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);

        emit(PhoneNumberAuthVerifyFailure(errorMessage));
      }
    });
  }
}
