import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/secure_storage/secure_storage.dart';

abstract class MovieLocalDataSource {
  Future<String> getEmailFromToken();
  Future<String> getSecuredUserEmail();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SecureStorage secureStorage;

  MovieLocalDataSourceImpl({
    required this.secureStorage,
  });

  @override
  Future<String> getEmailFromToken() async {
    final token = await secureStorage.read(key: Constants.apiToken);
    return Future.value(decodeEmailFromToken(token));
  }

  @override
  Future<String> getSecuredUserEmail() async =>
      await secureStorage.read(key: Constants.apiToken);

  static String decodeEmailFromToken(String token) {
    var decodedToken = JwtDecoder.decode(token);
    return decodedToken['email'];
  }
}
