import 'package:dio/dio.dart';

import '../http/dio_client_mix.dart';
import '../secure_storage/secure_storage.dart';
import 'movie_api_interceptor.dart';

class InterceptorManager {
  final DioClientMix dioClientMix;
  final SecureStorage secureStorage;

  InterceptorManager({
    required this.secureStorage,
    required this.dioClientMix,
  }) {
    dioClientMix.interceptors.addAll(listInterceptors());
  }

  List<Interceptor> listInterceptors() {
    return [
      // LogInterceptor(),
      MovieInterceptor(secureStorage: secureStorage),
    ];
  }
}
