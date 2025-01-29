import 'package:asd_test/core/constants/api.dart';
import 'package:asd_test/core/constants/constants.dart';
import 'package:asd_test/core/secure_storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class OTPInterceptor extends Interceptor {
  final SecureStorage secureStorage;

  OTPInterceptor({required this.secureStorage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    if (response.requestOptions.path == API.apiAuth) {
      secureOTPTempToken(token: response.data["token"]);
    }
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    super.onError(err, handler);
  }

  void secureOTPTempToken({required String token}) {
    secureStorage.write(
      key: Constants.securedOTPTempToken,
      value: token,
    );
  }
}
