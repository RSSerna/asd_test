import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/helpers/debouncer.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/add_remove_fav_param.dart';
import '../../domain/entities/cast_entity.dart';
import '../../domain/entities/get_movie_cast_param.dart';
import '../../domain/entities/get_popular_movie_param.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/search_movie_param.dart';
import '../../domain/usecase/add_remove_fav_usecase.dart';
import '../../domain/usecase/get_favs_usecase.dart';
import '../../domain/usecase/get_movie_cast_usecase.dart';
import '../../domain/usecase/get_popular_movies_usecase.dart';
import '../../domain/usecase/search_movie_usecase.dart';

class MovieProvider extends ChangeNotifier {
  MovieProvider({
    required GetMovieCastUsecase getMovieCastUsecase,
    required GetPopularMoviesUseCase getPopularMoviesUseCase,
    required SearchMovieUsecase searchMovieUsecase,
    required GetFavsUsecase getFavsUseCase,
    required AddRemoveFavUsecase addRemoveFavUsecase,
  })  : _getMovieCastUsecase = getMovieCastUsecase,
        _getPopularMoviesUseCase = getPopularMoviesUseCase,
        _searchMovieUsecase = searchMovieUsecase,
        _getFavsUsecase = getFavsUseCase,
        _addRemoveFavUsecase = addRemoveFavUsecase {
    getPopularMovies();
    getFavs();
  }

  // ---------------------------------------------------------------------------
  // Use cases
  // ---------------------------------------------------------------------------
  final GetMovieCastUsecase _getMovieCastUsecase;
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;
  final SearchMovieUsecase _searchMovieUsecase;
  final GetFavsUsecase _getFavsUsecase;
  final AddRemoveFavUsecase _addRemoveFavUsecase;

  // ---------------------------------------------------------------------------
  // Properties
  // ---------------------------------------------------------------------------
  List<Movie> popularMovie = [];
  List<String> favIds = [];
  Map<int, List<Cast>> movieCast = {};
  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStremController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream => _suggestionStremController.stream;

  Future getFavs() async {
    final failureOrAccepted = await _getFavsUsecase(NoParams());
    failureOrAccepted.fold((error) {}, (accepted) {
      favIds = accepted;
    });
    notifyListeners();
  }

  Future addRemoveFav(int id) async {
    final failureOrAccepted =
        await _addRemoveFavUsecase(AddRemoveFavParam(id: id));
    failureOrAccepted.fold((error) {}, (accepted) {
      favIds = accepted;
    });
    notifyListeners();
  }

  Future getPopularMovies() async {
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
    List<Cast> cast = [];
    final failureOrAccepted =
        await _getMovieCastUsecase(GetMovieCastParam(id: id));

    failureOrAccepted.fold((error) {}, (accepted) {
      movieCast[id] = accepted;
      cast = accepted;
    });
    return cast;
  }

  Future<List<Movie>> searchMovie(String movie) async {
    List<Movie> foundMovies = [];
    final failureOrAccepted =
        await _searchMovieUsecase(SearchMovieParam(movie: movie));

    failureOrAccepted.fold((error) {}, (accepted) {
      var searchedMovies = accepted
          .map((movie) => Movie(heroID: 'search-${movie.id}', movieData: movie))
          .toList();
      foundMovies = searchedMovies;
    });

    return foundMovies;
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

  bool isFav(int id) => favIds.contains(id.toString());
}
