import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/movie.dart';
import '../repositories/base_movies_repository.dart';

 class TopRatedUseCase{
  final BaseMoviesRepository repository;

  TopRatedUseCase({required this.repository});

  Future<Either<Failure, List<Movie>>> call() async{
    return await repository.getTopRatedMovies();
  }
}