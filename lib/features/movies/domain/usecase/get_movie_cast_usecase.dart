import 'package:asd_test/features/movies/domain/entities/cast_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/get_movie_cast_param.dart';
import '../repositories/movie_repository.dart';

class GetMovieCastUsecase implements UseCase<List<Cast>, GetMovieCastParam> {
  final MovieRepository repository;

  GetMovieCastUsecase({required this.repository});

  @override
  Future<Either<Failure, List<Cast>>> call(GetMovieCastParam params) {
    return repository.getMovieCast(params);
  }
}
