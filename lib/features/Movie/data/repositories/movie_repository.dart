import 'package:dartz/dartz.dart';
import 'package:movie_app_clean_arch/core/errors/exception.dart';
import 'package:movie_app_clean_arch/core/errors/failure.dart';
import 'package:movie_app_clean_arch/features/Movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app_clean_arch/features/Movie/domain/entities/movie.dart';
import 'package:movie_app_clean_arch/features/Movie/domain/repositories/base_movies_repository.dart';

import '../../../../core/network/netwok_info.dart';
import '../datasources/movie_local_data_source.dart';

class MovieRepository extends BaseMoviesRepository {
  final BaseMovieRemoteDataSource remoteDataSource;
  final BaseLocalMovieDataSource localMovieDataSource;
  final NetworkInfo networkInfo;

  MovieRepository({required this.localMovieDataSource,required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getNowPlaying() async {

    final bool isConnected = await networkInfo.isConnected;
    if(isConnected){
      try {
        final result = await remoteDataSource.getNowPlayingMovies();
        localMovieDataSource.cacheNowPlaying(result);
        return Right(result);
      } on ServerException catch (failure){
        return Left(ServerFailure(failure.messageModel.statusMessage));
      }
    }else {
      try{
        final result = await localMovieDataSource.getNowPlayingMovies();
        return Right(result);
      } on EmptyCacheException catch (failure){
        return Left(EmptyCacheFailure(failure.error));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async{

    final bool isConnected = await networkInfo.isConnected;
    if(isConnected){
      try {
        final result = await remoteDataSource.getPopularMovies();
        localMovieDataSource.cachePopularMovie(result);
        return Right(result);
      } on ServerException catch (failure){
        return Left(ServerFailure(failure.messageModel.statusMessage));
      }
    }else {
      try{
        final result = await localMovieDataSource.getPopularMovies();
        return Right(result);
      } on EmptyCacheException catch (failure){

        return Left(EmptyCacheFailure(failure.error));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async{

    final bool isConnected = await networkInfo.isConnected;
    if(isConnected){
      try {

        final result = await remoteDataSource.getTopRatedMovies();
       localMovieDataSource.cacheTopRated(result);
        return Right(result);
      } on ServerException catch (failure){
        return Left(ServerFailure(failure.messageModel.statusMessage));
      }
    }else {
      try{
        final result = await localMovieDataSource.getTopRatedMovies();
        return Right(result);
      } on EmptyCacheException catch (failure){
        return Left(EmptyCacheFailure(failure.error));
      }
    }
  }

}
