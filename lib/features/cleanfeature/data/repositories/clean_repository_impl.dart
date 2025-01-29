import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/clean_param.dart';
import '../../domain/repositories/clean_repository.dart';
import '../datasource/clean_local_data_source.dart';
import '../datasource/clean_remote_data_source.dart';

class CleanRepositoryImpl implements CleanRepository {
  final CleanRemoteDataSource cleanRemoteDataSource;
  final CleanLocalDataSource cleanLocalDataSource;

  CleanRepositoryImpl({
    required this.cleanRemoteDataSource,
    required this.cleanLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> restorePassword() async {
    try {
      final email = await cleanLocalDataSource.getEmailFromToken();
      final remoteTrivia = await cleanRemoteDataSource.restorePassword(email);
      return Right(remoteTrivia);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword(
      CleanParams changePasswordParams) async {
    try {
      final email = await cleanLocalDataSource.getSecuredUserEmail();
      final remoteTrivia = await cleanRemoteDataSource.changePassword(
          changePasswordParams, email);
      return Right(remoteTrivia);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
