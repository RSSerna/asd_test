import 'package:dio/dio.dart';

import '../http/dio_client_mix.dart';
import '../http/http_retry.dart';
import '../secure_storage/secure_storage.dart';
import 'change_password_interceptor.dart';
import 'otp_interceptor.dart';

class InterceptorManager {
  final DioClientMix dioClientMix;
  final SecureStorage secureStorage;
  final HttpRetry httpRetry;

  InterceptorManager({
    required this.secureStorage,
    required this.httpRetry,
    required this.dioClientMix,
  }) {
    dioClientMix.interceptors.addAll(listInterceptors());
  }

  List<Interceptor> listInterceptors() {
    return [
      LogInterceptor(),
      OTPInterceptor(secureStorage: secureStorage),
      ChangePasswordInterceptor(secureStorage: secureStorage)
    ];
  }
}
