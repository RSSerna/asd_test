import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/secure_storage/secure_storage.dart';
import '../../domain/entities/add_remove_fav_param.dart';

abstract class MovieLocalDataSource {
  Future<List<String>> addRemoveFav(AddRemoveFavParam param);
  Future<List<String>> getFavs();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  MovieLocalDataSourceImpl({
    required this.secureStorage,
    required this.sharedPreferences,
  });

  @override
  Future<List<String>> addRemoveFav(AddRemoveFavParam param) async {
    List<String>? favs = sharedPreferences.getStringList(Constants.favs);
    if (favs == null) {
      favs = [param.id.toString()];
      await sharedPreferences.setStringList(Constants.favs, favs);
    } else {
      if (favs.contains(param.id.toString())) {
        favs.remove(param.id.toString());
      } else {
        favs.add(param.id.toString());
      }
      await sharedPreferences.setStringList(Constants.favs, favs);
    }
    return favs;
  }

  @override
  Future<List<String>> getFavs() async {
    return sharedPreferences.getStringList(Constants.favs) ?? <String>[];
  }
}
