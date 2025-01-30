import 'package:jwt_decoder/jwt_decoder.dart';

class PasswordTempToken {
  late final String email;
  late final int exp;
  PasswordTempToken(String token) {
    var decodedToken = JwtDecoder.decode(token);
    email = decodedToken['email'];
    exp = decodedToken['exp'];
  }

  static String getEmailFromToken(String token) {
    var decodedToken = JwtDecoder.decode(token);
    return decodedToken['email'];
  }
}
