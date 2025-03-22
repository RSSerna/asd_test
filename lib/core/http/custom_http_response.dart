import 'package:equatable/equatable.dart';

class CustomHttpResponse extends Equatable {
  const CustomHttpResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });
  final int statusCode;
  final String statusMessage;
  final Map<String, dynamic> data;

  @override
  List<Object> get props => [statusCode, statusMessage, data];
}
