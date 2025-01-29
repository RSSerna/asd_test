import 'package:asd_test/core/errors/exceptions.dart';
import 'package:dio/dio.dart';

abstract class BaseRemoteDataSource {
  dynamic handleError(DioException e);
}

mixin BaseRemoteDataSourceImpl implements BaseRemoteDataSource {
  @override
  dynamic handleError(DioException e) {
    // if (e.response == null || e.response!.statusCode == null) {
    //   throw ServerException(message: e.message.toString(), errorCode: 506);
    // }
    final statusCode = e.response!.statusCode ?? 0;
    switch (statusCode) {
      //Client Error Responses 4xx
      case 400:
        throw ServerException(
          message: e.message.toString(),
          errorCode: e.response!.statusCode!,
        );

      case 401:
        throw ServerException(
          message: e.message.toString(),
          errorCode: e.response!.statusCode!,
        );

      case 403:
        throw ServerException(
          message: e.message.toString(),
          errorCode: e.response!.statusCode!,
        );

      case 404:
        throw ServerException(
          message: e.message.toString(),
          errorCode: e.response!.statusCode!,
        );

      case 405:
        throw ServerException(
          message: e.message.toString(),
          errorCode: e.response!.statusCode!,
        );

      case 429:
        throw ServerException(
          message: e.message.toString(),
          errorCode: e.response!.statusCode!,
        );

      //Server Error Responses 5xx
      case 500:
        throw ServerException(
          message: e.message.toString(),
          errorCode: e.response!.statusCode!,
        );

      case 502:
        throw ServerException(
          message: e.message.toString(),
          errorCode: e.response!.statusCode!,
        );

      case 503:
        throw ServerException(
          message: e.message.toString(),
          errorCode: e.response!.statusCode!,
        );

      case 504:
        throw ServerException(
          message: e.message.toString(),
          errorCode: e.response!.statusCode!,
        );

      default:
        throw ServerException(message: e.message.toString(), errorCode: 500);
    }
  }
}
