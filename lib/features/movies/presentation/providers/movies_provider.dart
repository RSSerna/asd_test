import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/helpers/debouncer.dart';
import '../../domain/entities/cast_entity.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_entity.dart';

class MovieProvider extends ChangeNotifier {
  final String _baseURL = 'api.themoviedb.org';
  final String _apiKey = 'd2b9fff2c64df549c7232718ac2b77e3';
  final String _language = 'es-ES';

  List<Movie> popularMovie = [];

  Map<int, List<Cast>> movieCast = {};
  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStremController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream => _suggestionStremController.stream;

  MovieProvider() {
    // print('MovieProvider Inicializado');
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseURL, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  void getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('/3/movie/popular', _popularPage);

    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovie = [...popularMovie, ...popularResponse.results];

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int id) async {
    if (movieCast.containsKey(id)) {
      return movieCast[id]!;
    }
    // print('Info Cast');
    final jsonData = await _getJsonData('/3/movie/$id/credits');

    final creditsResponse = CreditsResponse.fromJson(jsonData);

    movieCast[id] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String movie) async {
    var url = Uri.https(_baseURL, '/3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': movie});

    final response = await http.get(url);

    final searchMovieResponse = SearchMovieResponse.fromJson(response.body);

    return searchMovieResponse.results;
  }

  void getSuggestionByQuery(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovie(value);
      _suggestionStremController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((value) => timer.cancel());
  }
}
