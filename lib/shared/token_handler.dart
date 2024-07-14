import 'package:jwt_decoder/jwt_decoder.dart';

class TokenHandler {
  static bool isExpired(token) {
    if (token == null) {
      return true;
    } else {
      bool isTokenExpired = JwtDecoder.isExpired(token);
      return isTokenExpired;
    }
  }
}
