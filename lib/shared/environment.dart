// ignore_for_file: non_constant_identifier_names, constant_identifier_names

enum EnvironmentType { prod, staging, local_dev, remote_dev }

class Environment {
  static final Environment _instance = Environment._init();
  static Environment get instance => _instance;
  Environment._init();
  static String API_VERSION = "v1";
  static const String STAGING_BASE_URL = "";

  static const String REMOTE_DEV_BASE_URL =
      "https://e-shop-api-dev.azurewebsites.net/api/";
  static const String PROD_BASE_URL = "";
  static String LOCAL_DEV_BASE_URL =
      "http://192.168.1.181:8000/api/$API_VERSION/";

  // authentication
  String REFRESH_TOKEN = "authentication/token/refresh/";
  String PHONE_NUMBER_AUTH = "authentication/phone-number-auth/";
  String VERIFY_PHONE_NUMBER =
      "authentication/verify-phone-number-and-sign-up/";
  String USER_REGISTRATION = "authentication/guest-registration/";
  String VERIFY_EMAI_URL = "authentication/activate-account/";
  String LOGIN_URL = "authentication/login/";
  String RESEND_OTP_URL = "authentication/resend-otp/";
  String PHONE_NUMBER_VERIFY = "authentication/verify-phone-number-and-login/";
  String FORGET_PASSWORD_URL = "authentication/get-reset-password-token/";
  String CONFIRM_RESET_PASSWORD = "authentication/confirm-reset-password/";
  String LOGOUT_URL = "authentication/token/blacklist/";

  // user data
  String USER_PROFILE = "user-data/user-profile/";
  String MY_FAVORITE_PROPERTY = "user-data/my-favorite-property/";
  String MY_BOOKING_VIEW_SET = "user-data/my-booking-view-set/";
  String MY_BOOKING_BANK_PAYMENT_DETAILS =
      "user-data/my-booking-bank-payment-details/";
  String MY_MOBILE_MONEY_PAYMENT_INFOS =
      "user-data/my-mobile-money-payment-infos/";
  String CONFIRM_BOOKING = "user-data/confirm-booking/";
  String CONFIRM_RENTING = "user-data/confirm-renting-mwm/";
  String MY_RENTING = "user-data/my-renting/";
  String MY_RENTING_REQUEST = "user-data/my-renting-request/";
  String MY_BOOKING_REQUEST = "user-data/my-booking-request/";

  // properties
  String PROPERTIES = "property/property-list/";
  String PROPERTY_DETAIL = "property/property-details/";
  String PROPERTY_CATEGORIES = "property/categories/";
  String PROPERTY_REVIEW = "property/review-property/";
  static EnvironmentType environmentType = EnvironmentType.local_dev;

  // fcm
  String FCM_TOKEN_URL = "fcm/fcm-token/";
  String SEND_NOTIFICATION = "fcm/send-notification/";

  // ejabberd api
  String MY_ROSTER = "ejabberd/my-rosters/";
  String ADD_ROSTER = "ejabberd/add-roster/";

  String get getBaseUrl {
    switch (environmentType) {
      case EnvironmentType.staging:
        return STAGING_BASE_URL;
      case EnvironmentType.prod:
        return PROD_BASE_URL;
      case EnvironmentType.local_dev:
        return LOCAL_DEV_BASE_URL;
      case EnvironmentType.remote_dev:
        return REMOTE_DEV_BASE_URL;
    }
  }
}
