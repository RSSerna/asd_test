import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/movie_entity.dart';
import '../entities/search_movie_param.dart';
import '../repositories/clean_repository.dart';

class SearchMovieUsecase implements UseCase<MovieEntity, SearchMovieParam> {
  final MovieRepository repository;

  SearchMovieUsecase({required this.repository});

  @override
  Future<Either<Failure, MovieEntity>> call(SearchMovieParam params) {
    return repository.searchMovie(params);
  }
}
