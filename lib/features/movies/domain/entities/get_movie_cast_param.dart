import 'package:equatable/equatable.dart';

//Used only for sending parameters to the CleanRepository
class GetMovieCastParam extends Equatable {
  final int id;

  const GetMovieCastParam({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
