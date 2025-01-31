import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/get_popular_movie_param.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetPopularMoviesUseCase
    implements UseCase<List<MovieEntity>, GetPopularMoviesParam> {
  final MovieRepository repository;

  GetPopularMoviesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MovieEntity>>> call(
      GetPopularMoviesParam params) {
    return repository.getPopularMovies(params);
  }
}
