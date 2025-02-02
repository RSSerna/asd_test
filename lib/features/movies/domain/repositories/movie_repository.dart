import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/add_remove_fav_param.dart';
import '../entities/cast_entity.dart';
import '../entities/get_movie_cast_param.dart';
import '../entities/get_popular_movie_param.dart';
import '../entities/movie_entity.dart';
import '../entities/search_movie_param.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(
      GetPopularMoviesParam param);
  Future<Either<Failure, List<Cast>>> getMovieCast(GetMovieCastParam param);
  Future<Either<Failure, List<MovieEntity>>> searchMovie(
      SearchMovieParam param);
  Future<Either<Failure, List<String>>> addRemoveFav(AddRemoveFavParam param);
  Future<Either<Failure, List<String>>> getFavs(NoParams param);
}
