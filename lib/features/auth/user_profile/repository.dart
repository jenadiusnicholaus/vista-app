import '../../../data/sample_data.dart';
import '../../../shared/api_call/api.dart';
import '../../../shared/environment.dart';
import 'models.dart';

class UserProfileRepository {
  final DioApiCall apiCall;
  final Environment environment;
  UserProfileRepository({
    required this.apiCall,
    required this.environment,
  });

  Future<UserProfileModel> getUserProfile() async {
    var response =
        await apiCall.get(environment.getBaseUrl + environment.USER_PROFILE);
    if (response.statusCode == 200) {
      UserProfileModel userProfileModel =
          UserProfileModel.fromJson(response.data);
      return userProfileModel;
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {}

  Future<dynamic> createMyBankPaymentDetails(
      {required dynamic bankName,
      required dynamic accountNumber,
      required dynamic accountName,
      s
      // required String cardNumber,
      // required dynamic property,
      }) async {
    var data = {
      "account_number": accountNumber,
      "card_holder_name": accountName,
      "bank_name": bankName,
    };
    // log(data);

    var response = await apiCall.post(
        "${environment.getBaseUrl}${environment.MY_BOOKING_BANK_PAYMENT_DETAILS}",
        data: data);

    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw response.data;
    }
  }

  //  update bank payment details
  Future<dynamic> updateMyBankPaymentDetails({
    required dynamic bankName,
    required dynamic accountNumber,
    required dynamic accountName,
    required dynamic cardInfoId,
  }) async {
    var data = {
      "account_number": accountNumber,
      "card_holder_name": accountName,
      "bank_name": bankName,
    };

    var response = await apiCall.patch(
        "${environment.getBaseUrl}${environment.MY_BOOKING_BANK_PAYMENT_DETAILS}?card_info_id=$cardInfoId",
        data);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw response.data;
    }
  }

  // add my mw payment details to the database
  Future<dynamic> createMyMwPaymentDetails({
    required dynamic mobileNumber,
    required dynamic mobileNetwork,
  }) async {
    var data = {
      "mobile_money_number": mobileNumber,
      "mobile_money_network": mobileNetwork,
    };

    var response = await apiCall.post(
        "${environment.getBaseUrl}${environment.MY_MOBILE_MONEY_PAYMENT_INFOS}",
        data: data);

    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw response.data;
    }
  }

  // update my mw payment details
  Future<dynamic> updateMyMwPaymentDetails({
    required dynamic mobileNumber,
    required dynamic mobileNetwork,
    required dynamic mobileMoneyId,
  }) async {
    var data = {
      "mobile_money_number": mobileNumber,
      "mobile_money_network": mobileNetwork,
    };

    var response = await apiCall.patch(
        "${environment.getBaseUrl}${environment.MY_MOBILE_MONEY_PAYMENT_INFOS}?mobile_money_id=$mobileMoneyId",
        data);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw response.data;
    }
  }
}
