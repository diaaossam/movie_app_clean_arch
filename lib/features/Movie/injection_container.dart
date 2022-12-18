import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app_clean_arch/core/network/netwok_info.dart';
import 'package:movie_app_clean_arch/features/Movie/data/datasources/movie_local_data_source.dart';
import 'package:movie_app_clean_arch/features/Movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app_clean_arch/features/Movie/data/repositories/movie_repository.dart';
import 'package:movie_app_clean_arch/features/Movie/domain/repositories/base_movies_repository.dart';
import 'package:movie_app_clean_arch/features/Movie/domain/usecases/now_playing_usecase.dart';
import 'package:movie_app_clean_arch/features/Movie/domain/usecases/popular_movies_usecase.dart';
import 'package:movie_app_clean_arch/features/Movie/presentation/cubit/movie_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/usecases/top_rated_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Blocs
  sl.registerFactory<MovieCubit>(() => MovieCubit(
      nowPlayUseCase: sl(), topRatedUseCase: sl(), popularUseCase: sl()));

  // Use cases

  sl.registerLazySingleton<NowPlayUseCase>(
      () => NowPlayUseCase(repository: sl()));
  sl.registerLazySingleton<TopRatedUseCase>(
      () => TopRatedUseCase(repository: sl()));
  sl.registerLazySingleton<PopularMoviesUseCase>(
      () => PopularMoviesUseCase(repository: sl()));

  // Repository

  sl.registerLazySingleton<BaseMoviesRepository>(() => MovieRepository(
      localMovieDataSource: sl(), networkInfo: sl(), remoteDataSource: sl()));

  // Data Sources

  sl.registerLazySingleton<BaseMovieRemoteDataSource>(
      () => MovieRemoteDataSource(dio: sl()));
  sl.registerLazySingleton<BaseLocalMovieDataSource>(
      () => LocalMovieDataSource(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
