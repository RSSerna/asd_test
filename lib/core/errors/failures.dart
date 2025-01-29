import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<dynamic> properties;

  const Failure({this.properties = const []});

  @override
  List<Object?> get props => [properties];
}

class ServerFailure extends Failure {
  const ServerFailure(String message);
}

class CacheFailure extends Failure {}

class SecureStorageFailure extends Failure {}
