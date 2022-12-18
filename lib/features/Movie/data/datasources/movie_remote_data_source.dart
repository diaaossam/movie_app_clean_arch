import 'package:dio/dio.dart';
import 'package:movie_app_clean_arch/core/errors/exception.dart';
import 'package:movie_app_clean_arch/core/network/error_message_model.dart';
import 'package:movie_app_clean_arch/core/utils/end_points.dart';
import 'package:movie_app_clean_arch/features/Movie/data/models/movie_model.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getTopRatedMovies();
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  List<MovieModel> nowPlayingMoviesList = [];
  List<MovieModel> topRatedMoviesList = [];
  List<MovieModel> popularMoviesList = [];

  Dio dio;


  MovieRemoteDataSource({required this.dio});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await dio.get(EndPoints.nowPlaying);
    if (response.statusCode == 200) {
      nowPlayingMoviesList.clear();
      response.data['results'].forEach((e) {
        MovieModel model = MovieModel.fromJson(e);
        nowPlayingMoviesList.add(model);
      });
      return nowPlayingMoviesList;
    } else {
      throw ServerException(messageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await dio.get(EndPoints.popularMovies);
    if (response.statusCode == 200) {
      popularMoviesList.clear();
      response.data['results'].forEach((e) {
        MovieModel model = MovieModel.fromJson(e);
        popularMoviesList.add(model);
      });
      return popularMoviesList;
    } else {
      throw ServerException(messageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    try{
      final response = await dio.get(EndPoints.topRatedMovies);
      topRatedMoviesList.clear();
      response.data['results'].forEach((e) {
        MovieModel model = MovieModel.fromJson(e);
        topRatedMoviesList.add(model);
      });
      return topRatedMoviesList;
    }on DioError catch(error){
      throw ServerException(messageModel: ErrorMessageModel.fromJson(error.response!.data));
    }
  }
}
