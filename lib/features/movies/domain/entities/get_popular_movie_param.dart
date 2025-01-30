import 'package:equatable/equatable.dart';

//Used only for sending parameters to the CleanRepository
class GetPopularMoviesParam extends Equatable {
  final int page;

  const GetPopularMoviesParam({
    required this.page,
  });

  @override
  List<Object?> get props => [page];
}
