import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/helpers/debouncer.dart';
import '../../domain/entities/cast_entity.dart';
import '../../domain/entities/get_movie_cast_param.dart';
import '../../domain/entities/get_popular_movie_param.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/search_movie_param.dart';
import '../../domain/usecase/get_movie_cast_usecase.dart';
import '../../domain/usecase/get_popular_movies_usecase.dart';
import '../../domain/usecase/search_movie_usecase.dart';

class MovieProvider extends ChangeNotifier {
  MovieProvider(
      {required GetMovieCastUsecase getMovieCastUsecase,
      required GetPopularMoviesUseCase getPopularMoviesUseCase,
      required SearchMovieUsecase searchMovieUsecase})
      : _getMovieCastUsecase = getMovieCastUsecase,
        _getPopularMoviesUseCase = getPopularMoviesUseCase,
        _searchMovieUsecase = searchMovieUsecase {
    getPopularMovies();
  }

  // ---------------------------------------------------------------------------
  // Use cases
  // ---------------------------------------------------------------------------
  final GetMovieCastUsecase _getMovieCastUsecase;
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;
  final SearchMovieUsecase _searchMovieUsecase;

  // ---------------------------------------------------------------------------
  // Properties
  // ---------------------------------------------------------------------------
  List<Movie> popularMovie = [];
  Map<int, List<Cast>> movieCast = {};
  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStremController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream => _suggestionStremController.stream;

  void getPopularMovies() async {
    _popularPage++;
    final failureOrAccepted = await _getPopularMoviesUseCase(
        GetPopularMoviesParam(page: _popularPage));
    failureOrAccepted.fold((error) {}, (accepted) {
      var newPopularMovie = accepted
          .map(
              (movie) => Movie(heroID: 'popular-${movie.id}', movieData: movie))
          .toList();
      popularMovie = [...popularMovie, ...newPopularMovie];
    });

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int id) async {
    if (movieCast.containsKey(id)) {
      return movieCast[id]!;
    }
    final failureOrAccepted =
        await _getMovieCastUsecase(GetMovieCastParam(id: id));

    failureOrAccepted.fold((error) {}, (accepted) {
      movieCast[id] = accepted;
      return accepted;
    });
    return [];
  }

  Future<List<Movie>> searchMovie(String movie) async {
    final failureOrAccepted =
        await _searchMovieUsecase(SearchMovieParam(movie: movie));

    failureOrAccepted.fold((error) {}, (accepted) {
      var searchedMovies = accepted
          .map((movie) => Movie(heroID: 'search-${movie.id}', movieData: movie))
          .toList();
      return searchedMovies;
    });

    return [];
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
