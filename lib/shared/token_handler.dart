import 'package:jwt_decoder/jwt_decoder.dart';

class TokenHandler {
  static bool isExpired(token) {
    bool isTokenExpired = JwtDecoder.isExpired(token);

    if (token == null && isTokenExpired == true) {
      return true;
    } else {
      return isTokenExpired;
    }
  }

  static getTokenTime(token, String claim) {
    Duration tokenTime = JwtDecoder.getTokenTime(token);

    if (token == null) {
      return null;
    } else {
      return tokenTime;
    }
  }
}
