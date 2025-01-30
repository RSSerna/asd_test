import '../../../../core/constants/api.dart';
import '../../../../core/http/custom_http_client.dart';
import '../../domain/entities/get_movie_cast_param.dart';
import '../model/change_password_model.dart';

abstract class CleanRemoteDataSource {
  Future<bool> restorePassword(String email);
  Future<bool> changePassword(CleanParams changePasswordParams, String email);
}

class CleanRemoteDataSourceImpl implements CleanRemoteDataSource {
  final CustomHttpClient client;

  CleanRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<bool> restorePassword(String email) async {
    await client.put(path: API.apiAuth, body: email);
    return true;
  }

  @override
  Future<bool> changePassword(
      CleanParams changePasswordParams, String email) async {
    await client.put(
        path: API.apiAuth,
        body: CleanModel(
                email: email,
                password: changePasswordParams.password,
                newPassword: changePasswordParams.newPassword)
            .toJson());
    return true;
  }
}
