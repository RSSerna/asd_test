import 'package:asd_test/features/movies/domain/entities/cast_entity.dart';
import 'package:asd_test/features/movies/domain/entities/get_popular_movie_param.dart';
import 'package:asd_test/features/movies/domain/entities/movie_entity.dart';
import 'package:asd_test/features/movies/domain/entities/search_movie_param.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/get_movie_cast_param.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasource/clean_local_data_source.dart';
import '../datasource/clean_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource;
  final CleanLocalDataSource cleanLocalDataSource;

  MovieRepositoryImpl({
    required this.movieRemoteDataSource,
    required this.cleanLocalDataSource,
  });

  @override
  Future<Either<Failure, List<Cast>>> getMovieCast(
      GetMovieCastParam param) async {
    try {
      final remoteMovieCast = await movieRemoteDataSource.getMovieCast(param);
      return Right(remoteMovieCast);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(
      GetPopularMoviesParam param) async {
    try {
      final remotePopularMovies =
          await movieRemoteDataSource.getPopularMovies(param);
      return Right(remotePopularMovies);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> searchMovie(
      SearchMovieParam param) async {
    try {
      final searchedMovies = await movieRemoteDataSource.searchMovie(param);
      return Right(searchedMovies);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
