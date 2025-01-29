import 'package:asd_test/core/errors/failures.dart';
import 'package:asd_test/features/cleanfeature/domain/entities/clean_param.dart';
import 'package:dartz/dartz.dart';

abstract class CleanRepository {
  Future<Either<Failure, bool>> restorePassword();
  Future<Either<Failure, bool>> changePassword(
      CleanParams restorePasswordParams);
}
