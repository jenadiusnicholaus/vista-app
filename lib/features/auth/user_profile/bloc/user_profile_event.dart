part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

class GetUserProfileEvent extends UserProfileEvent {}

class UpdateUserProfileEvent extends UserProfileEvent {
  final UserProfileModel userProfileModel;

  UpdateUserProfileEvent(this.userProfileModel);
}

// create my Bank Account infos
class AddBankAccountInfos extends UserProfileEvent {
  final dynamic bankName;
  final dynamic accountNumber;
  final dynamic accountName;

  final dynamic property;
  final RequestContext requestContext;
  AddBankAccountInfos({
    required this.bankName,
    required this.accountNumber,
    required this.accountName,

    // required this.cardNumber,
    required this.property,
    required this.requestContext,
  });
}

// update my Bank Account infos
class UpdateBankAccountInfos extends UserProfileEvent {
  final dynamic bankName;
  final dynamic accountNumber;
  final dynamic accountName;

  final dynamic property;
  final RequestContext requestContext;
  final dynamic cardInfoId;
  UpdateBankAccountInfos({
    this.bankName,
    this.accountNumber,
    this.accountName,
    this.property,
    required this.requestContext,
    required this.cardInfoId,
  });
}

// add my Mobile Money Payment infos
// required dynamic mobileNumber,
// required dynamic mobileNetwork,

class AddMobileMoneyPaymentInfos extends UserProfileEvent {
  final dynamic mobileNumber;
  final dynamic mobileNetwork;
  final RequestContext requestContext;

  final dynamic property;
  AddMobileMoneyPaymentInfos({
    this.mobileNumber,
    this.mobileNetwork,
    this.property,
    required this.requestContext,
  });
}

// update my Mobile Money Payment infos

class UpdateMobileMoneyPaymentInfos extends UserProfileEvent {
  final dynamic mobileNumber;
  final dynamic mobileNetwork;
  final dynamic mobileMoneyId;
  final RequestContext requestContext;
  final dynamic property;
  UpdateMobileMoneyPaymentInfos({
    this.mobileNumber,
    this.mobileNetwork,
    this.property,
    required this.requestContext,
    required this.mobileMoneyId,
  });
}
