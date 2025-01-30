import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/language/bloc/language_bloc.dart';
import '../../features/movies/data/datasource/clean_remote_data_source.dart';
import '../../features/movies/data/repositories/clean_repository_impl.dart';
import '../../features/movies/domain/repositories/clean_repository.dart';
import '../../features/movies/domain/usecase/clean_params_usecase.dart';
import '../../features/movies/domain/usecase/get_popular_movies_usecase.dart';
import '../http/custom_http_client.dart';
import '../http/dio_client_mix.dart';
import '../interceptors/interceptor_manager.dart';
import '../secure_storage/secure_storage.dart';
import '../shared_preferences/custom_shared_preferences.dart';

abstract class InjectionContainer {
  Future<void> init();
}

class InjectionContainerImpl implements InjectionContainer {
  final sl = GetIt.instance;

  @override
  Future<void> init() async {
    ///Features

    ///Password Manager
    //Bloc
    sl.registerFactory(
        () => CleanBloc(changePassword: sl(), restorePassword: sl()));

    //Usecases
    sl.registerLazySingleton(() => GetPopularMoviesUseCase(repository: sl()));
    sl.registerLazySingleton(() => CleanParamsUseCase(repository: sl()));

    //Repository
    sl.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(
          cleanRemoteDataSource: sl(), cleanLocalDataSource: sl()),
    );

    //Data
    sl.registerLazySingleton<CleanRemoteDataSource>(
      () => CleanRemoteDataSourceImpl(client: sl()),
    );

    ///Language
    //Bloc
    sl.registerFactory(LanguageBloc.new);

    ///Core
    sl.registerLazySingleton<SecureStorage>(() => SecureStorageImpl(sl()));
    sl.registerLazySingleton<CustomSharedPreferences>(
      () => CustomSharedPreferencesImpl(sharedPreferences: sl()),
    );

    //Secure Storage
    sl.registerLazySingleton(() => const FlutterSecureStorage());

    //Shared Preferences
    sl.registerSingletonAsync(
      () async => await SharedPreferences.getInstance(),
    );

    //Dio
    sl.registerLazySingleton(Dio.new);
    sl.registerLazySingleton(() => DioClientMix(client: sl()));
    sl.registerLazySingleton<CustomHttpClient>(
      () => CustomHttpClientImpl(clientMix: sl()),
    );

    //Interceptor Manager
    sl.registerSingletonAsync(() async => InterceptorManager(
          dioClientMix: sl(),
          secureStorage: sl(),
          httpRetry: sl(),
        ));
  }
}
