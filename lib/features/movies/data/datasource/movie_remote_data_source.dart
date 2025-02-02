import '../../../../core/constants/api.dart';
import '../../../../core/http/custom_http_client.dart';
import '../../domain/entities/cast_entity.dart';
import '../../domain/entities/get_movie_cast_param.dart';
import '../../domain/entities/get_popular_movie_param.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/entities/search_movie_param.dart';
import '../model/credits_response.dart';
import '../model/popular_response.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieEntity>> getPopularMovies(GetPopularMoviesParam param);
  Future<List<Cast>> getMovieCast(GetMovieCastParam param);
  Future<List<MovieEntity>> searchMovie(SearchMovieParam param);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final CustomHttpClient client;

  MovieRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<Cast>> getMovieCast(GetMovieCastParam param) async {
    final response = await client.get(
        path: API.movieCast.replaceFirst('{{movieId}}', param.id.toString()),
        parameters: {'language': 'es-ES'});
    return CreditsResponse.fromMap(response.data).cast;
  }

  @override
  Future<List<MovieEntity>> getPopularMovies(
      GetPopularMoviesParam param) async {
    final response = await client.get(
        path: API.popularMovies,
        parameters: {'language': 'es-ES', 'page': param.page.toString()});
    return PopularResponse.fromMap(response.data).results;
  }

  @override
  Future<List<MovieEntity>> searchMovie(SearchMovieParam param) async {
    final response = await client.get(path: API.movieSearch, parameters: {
      'language': 'es-ES',
      'query': param.movie,
      'page': param.page.toString()
    });
    return PopularResponse.fromMap(response.data).results;
  }
}
