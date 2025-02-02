import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/add_remove_fav_param.dart';
import '../repositories/movie_repository.dart';

class AddRemoveFavUsecase implements UseCase<List<String>, AddRemoveFavParam> {
  final MovieRepository repository;

  AddRemoveFavUsecase({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(AddRemoveFavParam params) {
    return repository.addRemoveFav(params);
  }
}
