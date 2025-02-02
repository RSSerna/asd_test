import 'package:asd_test/features/settings/providers/language_provider.dart';
import 'package:asd_test/features/settings/providers/theme_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/movies/data/datasource/movie_local_data_source.dart';
import '../../features/movies/data/datasource/movie_remote_data_source.dart';
import '../../features/movies/data/repositories/movie_repository_impl.dart';
import '../../features/movies/domain/repositories/movie_repository.dart';
import '../../features/movies/domain/usecase/get_movie_cast_usecase.dart';
import '../../features/movies/domain/usecase/get_popular_movies_usecase.dart';
import '../../features/movies/domain/usecase/search_movie_usecase.dart';
import '../../features/movies/presentation/providers/movies_provider.dart';
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

  Future<void> initProvider() async {
    ///Movies
    sl.registerFactory(() => MovieProvider(
        getMovieCastUsecase: sl(),
        getPopularMoviesUseCase: sl(),
        searchMovieUsecase: sl()));
    //Theme
    sl.registerFactory(() => ThemeProvider(prefs: sl()));
    //Language
    sl.registerFactory(() => LanguageProvider(prefs: sl()));
  }

  @override
  Future<void> init() async {
    //State Managment
    initProvider();

    //Features
    //Movies
    //Usecases
    sl.registerLazySingleton(() => GetPopularMoviesUseCase(repository: sl()));
    sl.registerLazySingleton(() => GetMovieCastUsecase(repository: sl()));
    sl.registerLazySingleton(() => SearchMovieUsecase(repository: sl()));

    //Repository
    sl.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(
          movieRemoteDataSource: sl(), cleanLocalDataSource: sl()),
    );

    //Data
    sl.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: sl()),
    );
    sl.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(secureStorage: sl()),
    );

    ///Language
    //Bloc
    // sl.registerFactory(LanguageBloc.new);

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
        ));
  }
}
