import 'package:equatable/equatable.dart';

//Used only for sending parameters to the CleanRepository
class AddRemoveFavParam extends Equatable {
  final int id;

  const AddRemoveFavParam({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
