import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_arch/features/Movie/domain/entities/movie.dart';
import 'package:movie_app_clean_arch/features/Movie/domain/usecases/popular_movies_usecase.dart';
import 'package:movie_app_clean_arch/features/Movie/domain/usecases/top_rated_usecase.dart';

import '../../domain/usecases/now_playing_usecase.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final NowPlayUseCase nowPlayUseCase;
  final TopRatedUseCase topRatedUseCase;
  final PopularMoviesUseCase popularUseCase;

  MovieCubit(
      {required this.topRatedUseCase,
      required this.popularUseCase,
      required this.nowPlayUseCase})
      : super(MovieInitial());

  void getNowPlaying() async {
    emit(GetNowPlayingLoading());
    final nowPlaying = await nowPlayUseCase.repository.getNowPlaying();
    final popular = await nowPlayUseCase.repository.getPopularMovies();
    final topRated = await nowPlayUseCase.repository.getTopRatedMovies();
   emit( nowPlaying.fold(
         (error) => GetNowPlayingFailure(error.message),
         (nowPlayingList) {
      return popular.fold((err) => GetPopularFailure(err.message), (popularList) {
        return topRated.fold((er) => GetTopRatedFailure(er.message), (topRatedList) =>GetNowPlayingSuccess(
             nowPlayingList: nowPlayingList,
             popularList: popularList,
             topRatedList: topRatedList)
         );
       });
     },
   ));
  }
}
