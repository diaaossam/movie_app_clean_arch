import 'package:dartz/dartz.dart';
import 'package:movie_app_clean_arch/features/Movie/domain/repositories/base_movies_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/movie.dart';

 class NowPlayUseCase{
  final BaseMoviesRepository repository;

  NowPlayUseCase({required this.repository});

  Future<Either<Failure, List<Movie>>> call() async{
    return await repository.getNowPlaying();
  }
}