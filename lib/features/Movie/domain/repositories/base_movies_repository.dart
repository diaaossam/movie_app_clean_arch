import 'package:dartz/dartz.dart';
import 'package:movie_app_clean_arch/features/Movie/domain/entities/movie.dart';

import '../../../../core/errors/failure.dart';

abstract class BaseMoviesRepository{
  Future<Either<Failure,List<Movie>>> getNowPlaying();
  Future<Either<Failure,List<Movie>>> getPopularMovies();
  Future<Either<Failure,List<Movie>>> getTopRatedMovies();
}