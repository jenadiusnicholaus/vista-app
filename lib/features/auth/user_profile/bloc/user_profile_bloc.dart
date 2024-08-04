import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vista/features/auth/user_profile/models.dart';
import 'package:vista/features/auth/user_profile/repository.dart';

import '../../../../constants/consts.dart';
import '../../../../shared/error_handler.dart';
import '../../../../shared/utils/local_storage.dart';
import '../../../../shared/utils/request_context.dart';

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
        await LocalStorage.write(
            key: 'phone_number',
            value: userProfileModel.phoneNumber.toString());
      } catch (e) {
        emit(UserProfileError("Error fetching user profile"));
      }
    });

    // AddBankAccountInfos

    on<AddBankAccountInfos>((event, emit) async {
      emit(AddBankAccountInfosLoading());
      try {
        await userProfileRepository.createMyBankPaymentDetails(
          bankName: event.bankName,
          accountNumber: event.accountNumber,
          accountName: event.accountName,
        );

        emit(AddBankAccountInfosSuccess());
        getTheRequestContext(event);
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);
        // log(errorMessage);
        emit(AddBankAccountInfosFailed(errorMessage));
      }
    });

    // UpdateBankAccountInfos
    on<UpdateBankAccountInfos>((event, emit) async {
      emit(UpdateBankAccountInfosLoading());
      try {
        await userProfileRepository.updateMyBankPaymentDetails(
          bankName: event.bankName,
          accountNumber: event.accountNumber,
          accountName: event.accountName,
          cardInfoId: event.cardInfoId,
        );
        emit(UpdateBankAccountInfosSuccess());
        getTheRequestContext(event);
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);
        emit(UpdateBankAccountInfosFailed(errorMessage));
      }
    });

    // AddMobileMoneyPaymentInfos

    on<AddMobileMoneyPaymentInfos>((event, emit) async {
      emit(AddMobileMoneyPaymentInfosLoading());
      try {
        await userProfileRepository.createMyMwPaymentDetails(
          mobileNumber: event.mobileNumber,
          mobileNetwork: event.mobileNetwork,
        );

        emit(AddMobileMoneyPaymentInfosSuccess());
        getTheRequestContext(event);
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);
        emit(AddMobileMoneyPaymentInfosFailed(errorMessage));
      }
    });

    // UpdateMobileMoneyPaymentInfos
    on<UpdateMobileMoneyPaymentInfos>((event, emit) async {
      emit(UpdateMobileMoneyPaymentInfosLoading());
      try {
        await userProfileRepository.updateMyMwPaymentDetails(
          mobileNumber: event.mobileNumber,
          mobileNetwork: event.mobileNetwork,
          mobileMoneyId: event.mobileMoneyId,
        );
        emit(UpdateMobileMoneyPaymentInfosSuccess());
        getTheRequestContext(event);
      } catch (e) {
        String errorMessage = ExceptionHandler.handleError(e);
        emit(UpdateMobileMoneyPaymentInfosFailed(errorMessage));
      }
    });
  }
}
