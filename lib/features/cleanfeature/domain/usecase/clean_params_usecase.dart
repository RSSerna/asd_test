import 'package:asd_test/core/errors/failures.dart';
import 'package:asd_test/core/usecase/usecase.dart';
import 'package:asd_test/features/cleanfeature/domain/entities/clean_param.dart';
import 'package:asd_test/features/cleanfeature/domain/repositories/clean_repository.dart';
import 'package:dartz/dartz.dart';

class CleanParamsUseCase implements UseCase<bool, CleanParams> {
  final CleanRepository repository;

  CleanParamsUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(CleanParams params) {
    return repository.changePassword(params);
  }
}
