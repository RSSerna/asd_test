import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/clean_repository.dart';

class CleanNoParamsUseCase implements UseCase<bool, NoParams> {
  final CleanRepository repository;

  CleanNoParamsUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.restorePassword();
  }
}
