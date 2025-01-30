import 'package:equatable/equatable.dart';

//Used only for sending parameters to the CleanRepository
class SearchMovieParam extends Equatable {
  final String movie;

  const SearchMovieParam({
    required this.movie,
  });

  @override
  List<Object?> get props => [movie];
}
