import 'package:dio/dio.dart';

import 'dio_client_mix.dart';

abstract class CustomHttpClient {
  Future<Response> get({
    required String path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? parameters,
  });
  Future<Response> post({
    required String path,
    dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? parameters,
  });
  Future<Response> delete({
    required String path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? parameters,
  });
  Future<Response> put({
    required String path,
    dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? parameters,
  });
  Future<Response> request({
    required RequestOptions requestOptions,
  });
}

class CustomHttpClientImpl implements CustomHttpClient {
  final DioClientMix clientMix;

  CustomHttpClientImpl({
    required this.clientMix,
  });

  @override
  Future<Response<dynamic>> get({
    required String path,
    body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? parameters,
  }) async =>
      await clientMix.get(path,
          data: body,
          options: Options(headers: headers),
          queryParameters: parameters);

  @override
  Future<Response> post({
    required String path,
    body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? parameters,
  }) async =>
      await clientMix.post(
        path,
        data: body,
        options: Options(headers: headers),
        queryParameters: parameters,
      );

  @override
  Future<Response> delete({
    required String path,
    dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? parameters,
  }) async =>
      await clientMix.delete(
        path,
        data: body,
        options: Options(headers: headers),
        queryParameters: parameters,
      );

  @override
  Future<Response> put({
    required String path,
    body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? parameters,
  }) async =>
      await clientMix.put(
        path,
        data: body,
        options: Options(headers: headers),
        queryParameters: parameters,
      );

  @override
  Future<Response> request({
    required RequestOptions requestOptions,
  }) async =>
      await clientMix.request(
        requestOptions.path,
        cancelToken: requestOptions.cancelToken,
        data: requestOptions.data,
        onReceiveProgress: requestOptions.onReceiveProgress,
        onSendProgress: requestOptions.onSendProgress,
        queryParameters: requestOptions.queryParameters,
        options: Options(
          method: requestOptions.method,
          sendTimeout: requestOptions.sendTimeout,
          receiveTimeout: requestOptions.receiveTimeout,
          extra: requestOptions.extra,
          headers: requestOptions.headers,
          responseType: requestOptions.responseType,
          contentType: requestOptions.contentType,
          validateStatus: requestOptions.validateStatus,
          receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
          followRedirects: requestOptions.followRedirects,
          maxRedirects: requestOptions.maxRedirects,
          persistentConnection: requestOptions.persistentConnection,
          requestEncoder: requestOptions.requestEncoder,
          responseDecoder: requestOptions.responseDecoder,
          listFormat: requestOptions.listFormat,
        ),
      );
}
