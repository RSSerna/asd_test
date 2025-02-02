import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/movie_repository.dart';

class GetFavsUsecase implements UseCase<List<String>, NoParams> {
  final MovieRepository repository;

  GetFavsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) {
    return repository.getFavs(params);
  }
}
