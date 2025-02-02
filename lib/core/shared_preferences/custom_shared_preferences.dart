import 'package:shared_preferences/shared_preferences.dart';

import '../errors/exceptions.dart';

abstract class CustomSharedPreferences {
  //Set
  Future<void> setInt({required String key, required int value});
  Future<void> setBool({required String key, required bool value});
  Future<void> setDouble({required String key, required double value});
  Future<void> setString({required String key, required String value});
  Future<void> setStringList(
      {required String key, required List<String> value});

  //Read
  int getInt({required String key});
  bool getBool({required String key});
  double getDouble({required String key});
  String getString({required String key});
  List<String> getStringList({required String key});

  //Remove
  Future<bool> remove({required String key});
}

class CustomSharedPreferencesImpl extends CustomSharedPreferences {
  final SharedPreferences sharedPreferences;

  CustomSharedPreferencesImpl({required this.sharedPreferences});

  @override
  bool getBool({required String key}) {
    final bool? value = sharedPreferences.getBool(key);
    if (value != null) {
      return value;
    } else {
      throw CacheException();
    }
  }

  @override
  double getDouble({required String key}) {
    return _handleGetError(sharedPreferences.getDouble(key));
  }

  @override
  int getInt({required String key}) {
    return _handleGetError(sharedPreferences.getInt(key));
  }

  @override
  String getString({required String key}) {
    return _handleGetError(sharedPreferences.getString(key));
  }

  @override
  List<String> getStringList({required String key}) {
    return _handleGetError(sharedPreferences.getStringList(key));
  }

  @override
  Future<void> setBool({required String key, required bool value}) async {
    return await _handleSetError(sharedPreferences.setBool(key, value));
  }

  @override
  Future<void> setDouble({required String key, required double value}) async {
    return await _handleSetError(sharedPreferences.setDouble(key, value));
  }

  @override
  Future<void> setInt({required String key, required int value}) async {
    return await _handleSetError(sharedPreferences.setInt(key, value));
  }

  @override
  Future<void> setString({required String key, required String value}) async {
    return await _handleSetError(sharedPreferences.setString(key, value));
  }

  @override
  Future<void> setStringList(
      {required String key, required List<String> value}) async {
    return await _handleSetError(sharedPreferences.setStringList(key, value));
  }

  @override
  Future<bool> remove({required String key}) async {
    try {
      return await sharedPreferences.remove(key);
    } catch (e) {
      throw CacheException();
    }
  }

  dynamic _handleGetError(value) {
    if (value != null) {
      return value;
    } else {
      throw CacheException();
    }
  }

  Future<void> _handleSetError(Future<dynamic> function) async {
    try {
      await function;
    } catch (e) {
      throw CacheException();
    }
  }
}
