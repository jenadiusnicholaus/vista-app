// ignore_for_file: constant_identifier_names, non_constant_identifier_names

enum EnvironmentType { prod, staging, local_dev, remote_dev }

class Environment {
  static final Environment _instance = Environment._init();
  static Environment get instance => _instance;
  Environment._init();

  static String API_VERSION = "v1";

  // https://travel-monkey-app-backend-staging.azurewebsites.net/api/user-auth/v1/user-registration/

  static const String STAGING_BASE_URL = "";

  static const String REMOTE_DEV_BASE_URL =
      "https://e-shop-api-dev.azurewebsites.net/api/";
  static const String PROD_BASE_URL = "";
  static String LOCAL_DEV_BASE_URL =
      "http://192.168.1.181:8000/api/$API_VERSION/";

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

  static EnvironmentType environmentType = EnvironmentType.local_dev;

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

  static String IMAGE_URL = "http://192.168.1.181:8000";
}
