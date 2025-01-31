import 'package:equatable/equatable.dart';

//Used only for sending parameters to the CleanRepository
class SearchMovieParam extends Equatable {
  final String movie;
  final int page;

  const SearchMovieParam({
    required this.movie,
    this.page = 1,
  });

  @override
  List<Object?> get props => [movie, page];
}
