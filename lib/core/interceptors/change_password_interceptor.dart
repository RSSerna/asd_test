import 'package:asd_test/core/constants/api.dart';
import 'package:asd_test/core/constants/constants.dart';
import 'package:asd_test/core/secure_storage/secure_storage.dart';
import 'package:dio/dio.dart';

class ChangePasswordInterceptor extends Interceptor {
  final SecureStorage secureStorage;

  ChangePasswordInterceptor({required this.secureStorage});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('REQUEST[${options.method}] => PATH: ${options.path}');

    if (options.path == API.apiAuth) {
      final String bearerToken =
          await secureStorage.read(key: Constants.securedOTPTempToken);
      options.headers["Authorization"] = "Bearer $bearerToken";
    } else if (options.path == API.apiAuth) {
      final String bearerToken =
          await secureStorage.read(key: Constants.securedToken);
      options.headers["Authorization"] = "Bearer $bearerToken";
    }

    super.onRequest(options, handler);
  }
}
