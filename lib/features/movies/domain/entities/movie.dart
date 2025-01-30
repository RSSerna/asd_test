import 'package:asd_test/features/movies/domain/entities/movie_entity.dart';

class Movie {
  final MovieEntity movieData;
  String heroID;

  Movie({
    required this.movieData,
    required this.heroID,
  });
}
