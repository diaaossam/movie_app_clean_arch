part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class GetNowPlayingLoading extends MovieState {
  @override
  List<Object> get props => [];
}

class GetNowPlayingSuccess extends MovieState {
  final List<Movie> topRatedList;
  final List<Movie> nowPlayingList;
  final List<Movie> popularList;

  const GetNowPlayingSuccess(
      {required this.nowPlayingList, required this.popularList, required this.topRatedList});

  @override
  List<Object> get props => [topRatedList, nowPlayingList, popularList];

}

class GetNowPlayingFailure extends MovieState {
  final String msg;
  const GetNowPlayingFailure(this.msg);
  @override
  List<Object> get props => [msg];
}
class GetTopRatedFailure extends MovieState {
  final String msg;
  const GetTopRatedFailure(this.msg);
  @override
  List<Object> get props => [msg];
}
class GetPopularFailure extends MovieState {
  final String msg;
  const GetPopularFailure(this.msg);
  @override
  List<Object> get props => [msg];
}