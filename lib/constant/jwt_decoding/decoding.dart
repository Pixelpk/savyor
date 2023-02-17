import 'package:jwt_decoder/jwt_decoder.dart';

class JwtDecoding {
  static bool tokenHasExpired(String? token) {
    if (token == null) return true;
    return JwtDecoder.isExpired(token);
  }
}
