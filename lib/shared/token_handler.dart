import 'package:jwt_decoder/jwt_decoder.dart';

class TokenHandler {
  static bool isExpired(token) {
    if (token == null) {
      return true;
    }

    bool isTokenExpired = JwtDecoder.isExpired(token ?? '');
    return isTokenExpired;
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
