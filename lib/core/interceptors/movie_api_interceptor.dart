import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/api.dart';
import '../secure_storage/secure_storage.dart';

class MovieInterceptor extends Interceptor {
  final SecureStorage secureStorage;

  MovieInterceptor({required this.secureStorage}) {
    print("MovieInterceptor");
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    // final String apiKey = await secureStorage.read(key: Constants.apiToken);
    options.queryParameters.addAll({
      'api_key': API.apiKey,
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    super.onError(err, handler);
  }
}
