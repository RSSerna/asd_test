import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/http/custom_http_exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/add_remove_fav_param.dart';
import '../../domain/entities/cast_entity.dart';
import '../../domain/entities/get_movie_cast_param.dart';
import '../../domain/entities/get_popular_movie_param.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/entities/search_movie_param.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasource/movie_local_data_source.dart';
import '../datasource/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource;
  final MovieLocalDataSource cleanLocalDataSource;

  MovieRepositoryImpl({
    required this.movieRemoteDataSource,
    required this.cleanLocalDataSource,
  });

  Future<Either<Failure, T>> _safeApiCall<T>(
      Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();
      return Right(result);
    } on CustomHTTPException catch (e) {
      print("CustomExeption: $e");
      return Left(CustomHTTPFailure(
        code: e.code,
        message: e.message,
        path: e.path,
        data: e.data,
        headers: e.headers,
      ));
    } catch (e) {
      print("Failure: $e"); // Keep this for debugging
      return Left(ServerFailure(
          "An unexpected error occurred.")); // More user-friendly message
    }
  }

  @override
  Future<Either<Failure, List<Cast>>> getMovieCast(
      GetMovieCastParam param) async {
    return _safeApiCall(() => movieRemoteDataSource.getMovieCast(param));
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(
      GetPopularMoviesParam param) async {
    return _safeApiCall(() => movieRemoteDataSource.getPopularMovies(param));
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> searchMovie(
      SearchMovieParam param) async {
    return _safeApiCall(() => movieRemoteDataSource.searchMovie(param));
  }

  @override
  Future<Either<Failure, List<String>>> addRemoveFav(
      AddRemoveFavParam param) async {
    try {
      var favs = await cleanLocalDataSource.addRemoveFav(param);
      return Future.value(Right(favs));
    } catch (e) {
      return Future.value(Left(CacheFailure())); // More user-friendly message
    }
  }

  @override
  Future<Either<Failure, List<String>>> getFavs(NoParams param) async {
    try {
      return Future.value(Right(await cleanLocalDataSource.getFavs()));
    } catch (e) {
      return Future.value(Left(CacheFailure())); // More user-friendly message
    }
  }
}
