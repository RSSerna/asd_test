import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/get_movie_cast_param.dart';
import '../entities/movie_entity.dart';
import '../repositories/clean_repository.dart';

class GetMovieCastUsecase implements UseCase<MovieEntity, GetMovieCastParam> {
  final MovieRepository repository;

  GetMovieCastUsecase({required this.repository});

  @override
  Future<Either<Failure, MovieEntity>> call(GetMovieCastParam params) {
    return repository.getMovieCast(params);
  }
}
