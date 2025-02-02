import 'package:asd_test/features/movies/domain/entities/cast_entity.dart';
import 'package:asd_test/features/movies/domain/entities/movie.dart';
import 'package:asd_test/features/movies/domain/entities/movie_entity.dart';
import 'package:asd_test/features/movies/domain/usecase/get_movie_cast_usecase.dart';
import 'package:asd_test/features/movies/domain/usecase/get_popular_movies_usecase.dart';
import 'package:asd_test/features/movies/domain/usecase/search_movie_usecase.dart';
import 'package:asd_test/features/movies/presentation/providers/movies_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movies_provider_test.mocks.dart';

@GenerateMocks(
    [GetMovieCastUsecase, GetPopularMoviesUseCase, SearchMovieUsecase])
void main() {
  late MockGetMovieCastUsecase mockGetMovieCastUsecase;
  late MockGetPopularMoviesUseCase mockGetPopularMoviesUseCase;
  late MockSearchMovieUsecase mockSearchMovieUsecase;
  late MovieProvider movieProvider;

  const movie1 = MovieEntity(
    adult: false,
    genreIds: [1, 2, 3],
    id: 123,
    originalLanguage: 'en',
    originalTitle: 'Original Title',
    overview: 'Overview of the movie.',
    popularity: 9.5,
    title: 'Movie Title',
    video: false,
    voteAverage: 7.8,
    voteCount: 1000,
  );

  const movie2 = MovieEntity(
    adult: false,
    backdropPath: '/backdrop.jpg',
    genreIds: [1, 2, 3],
    id: 123,
    originalLanguage: 'en',
    originalTitle: 'Original Title',
    overview: 'Overview of the movie.',
    popularity: 9.5,
    posterPath: '/poster.jpg',
    releaseDate: '2024-01-01',
    title: 'Movie Title',
    video: false,
    voteAverage: 7.8,
    voteCount: 1000,
  );

  const movie3 = MovieEntity(
    adult: true, // Different value
    genreIds: [1, 2, 3],
    id: 123,
    originalLanguage: 'en',
    originalTitle: 'Original Title',
    overview: 'Overview of the movie.',
    popularity: 9.5,
    title: 'Movie Title',
    video: false,
    voteAverage: 7.8,
    voteCount: 1000,
  );

  const cast1 = Cast(
    adult: false,
    gender: 2,
    id: 123,
    knownForDepartment: 'Acting',
    name: 'Actor Name',
    originalName: 'Original Actor Name',
    popularity: 8.5,
    profilePath: '/profile.jpg',
    castId: 456,
    character: 'Character Name',
    creditId: 'credit123',
    order: 1,
    department: 'Actors',
    job: 'Actor',
  );

  const cast2 = Cast(
    adult: false,
    gender: 2,
    id: 123,
    knownForDepartment: 'Acting',
    name: 'Actor Name',
    originalName: 'Original Actor Name',
    popularity: 8.5,
    profilePath: '/profile.jpg',
    castId: 456,
    character: 'Character Name',
    creditId: 'credit123',
    order: 1,
    department: 'Actors',
    job: 'Actor',
  );

  setUp(() {
    mockGetMovieCastUsecase = MockGetMovieCastUsecase();
    mockGetPopularMoviesUseCase = MockGetPopularMoviesUseCase();
    mockSearchMovieUsecase = MockSearchMovieUsecase();

    movieProvider = MovieProvider(
      getMovieCastUsecase: mockGetMovieCastUsecase,
      getPopularMoviesUseCase: mockGetPopularMoviesUseCase,
      searchMovieUsecase: mockSearchMovieUsecase,
    );
  });

  tearDown(() {
    movieProvider.debouncer.dispose(); // Dispose of the debouncer
  });

  group('MovieProvider', () {
    test('getPopularMovies should fetch and update popular movies', () async {
      final mockMovies = [
        Movie(heroID: 'popular-1', movieData: movie1),
        Movie(heroID: 'popular-2', movieData: movie2),
      ];

      when(mockGetPopularMoviesUseCase(any)).thenAnswer((_) async =>
          Right([mockMovies[0].movieData, mockMovies[1].movieData]));

      await movieProvider.getPopularMovies();

      expect(movieProvider.popularMovie.length, 2);
      expect(movieProvider.popularMovie[0].heroID, 'popular-1');
      expect(movieProvider.popularMovie[1].heroID, 'popular-2');
    });

    test('getMovieCast should fetch and cache movie cast', () async {
      final mockCast = [
        cast1,
        cast2,
      ];

      when(mockGetMovieCastUsecase(any))
          .thenAnswer((_) async => Right(mockCast));

      final cast = await movieProvider.getMovieCast(1);

      expect(cast.length, 2);
      expect(movieProvider.movieCast[1], mockCast); // Check if cached
    });

    test('searchMovie should fetch and return searched movies', () async {
      final mockMovies = [
        Movie(heroID: 'search-1', movieData: movie3),
      ];
      when(mockSearchMovieUsecase(any))
          .thenAnswer((_) async => Right([mockMovies[0].movieData]));

      final movies = await movieProvider.searchMovie('Movie 1');

      expect(movies.length, 1);
      expect(movies[0].heroID, 'search-1');
    });

    test('getSuggestionByQuery should debounce and search', () async {
      final mockMovies = [
        Movie(heroID: 'search-1', movieData: movie1),
      ];

      when(mockSearchMovieUsecase(any))
          .thenAnswer((_) async => Right([mockMovies[0].movieData]));

      movieProvider.getSuggestionByQuery('Movie');

      // Wait for debounce to complete
      await Future.delayed(const Duration(milliseconds: 600)); // > 500ms

      expect(movieProvider.suggestionStream.length, greaterThan(0));
    });
  });
}
