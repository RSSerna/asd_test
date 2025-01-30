import 'package:asd_test/features/movies/domain/entities/get_popular_movie_param.dart';
import 'package:asd_test/features/movies/domain/entities/movie_entity.dart';
import 'package:asd_test/features/movies/domain/entities/search_movie_param.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/get_movie_cast_param.dart';
import '../../domain/repositories/clean_repository.dart';
import '../datasource/clean_local_data_source.dart';
import '../datasource/clean_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final CleanRemoteDataSource cleanRemoteDataSource;
  final CleanLocalDataSource cleanLocalDataSource;

  MovieRepositoryImpl({
    required this.cleanRemoteDataSource,
    required this.cleanLocalDataSource,
  });

  @override
  Future<Either<Failure, MovieEntity>> getMovieCast(
      GetMovieCastParam param) async {
    try {
      final email = await cleanLocalDataSource.getSecuredUserEmail();
      final remoteTrivia = await cleanRemoteDataSource.changePassword(
          changePasswordParams, email);
      return Right(remoteTrivia);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, MovieEntity>> getPopularMovies(
      GetPopularMoviesParam param) {
    // TODO: implement getPopularMovies
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MovieEntity>> searchMovie(SearchMovieParam param) {
    // TODO: implement searchMovie
    throw UnimplementedError();
  }

  // @override
  // Future<Either<Failure, bool>> changePassword(
  //     CleanParams changePasswordParams) async {
  //   try {
  //     final email = await cleanLocalDataSource.getSecuredUserEmail();
  //     final remoteTrivia = await cleanRemoteDataSource.changePassword(
  //         changePasswordParams, email);
  //     return Right(remoteTrivia);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message));
  //   }
  // }
}
