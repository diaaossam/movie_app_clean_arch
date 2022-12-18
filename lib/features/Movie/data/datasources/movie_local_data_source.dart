import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:movie_app_clean_arch/core/errors/exception.dart';
import 'package:movie_app_clean_arch/core/utils/app_strings.dart';
import 'package:movie_app_clean_arch/features/Movie/domain/entities/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movie_model.dart';

abstract class BaseLocalMovieDataSource{
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<Unit> cacheNowPlaying(List<MovieModel> list);

  Future<List<MovieModel>> getPopularMovies();
  Future<Unit> cachePopularMovie(List<MovieModel> list);

  Future<List<MovieModel>> getTopRatedMovies();
  Future<Unit> cacheTopRated(List<MovieModel> list);

}

class LocalMovieDataSource implements BaseLocalMovieDataSource{
  final SharedPreferences sharedPreferences;


  LocalMovieDataSource({required this.sharedPreferences});

  @override
  Future<Unit> cacheNowPlaying(List<MovieModel> movies) {
    List cached = movies.map<Map<String,dynamic>>((e) =>e.toJson()).toList();
    sharedPreferences.setString(AppStrings.cachedNowPlaying, json.encode(cached));
    return Future.value(unit);
  }

  @override
  Future<Unit> cachePopularMovie(List<MovieModel> movies) {
    List cached = movies.map<Map<String,dynamic>>((e) =>e.toJson()).toList();
    sharedPreferences.setString(AppStrings.cachedPopular, json.encode(cached));
    return Future.value(unit);
  }

  @override
  Future<Unit> cacheTopRated(List<MovieModel> movies) {
    List cached = movies.map<Map<String,dynamic>>((e) =>e.toJson()).toList();
    sharedPreferences.setString(AppStrings.cachedTopRated, json.encode(cached));
    return Future.value(unit);
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies() {
   final jsonString = sharedPreferences.getString(AppStrings.cachedNowPlaying);
   if(jsonString != null){
     List list= json.decode(jsonString);
     List<MovieModel> movieModelList= list.map<MovieModel>((model) => MovieModel.fromJson(model)).toList();
     return Future.value(movieModelList);
   }else{
     throw EmptyCacheException(error: AppStrings.emptyCacheException);
   }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() {
    final jsonString = sharedPreferences.getString(AppStrings.cachedPopular);
    if(jsonString !=null){
      List jsonList =  json.decode(jsonString) as List;
      List<MovieModel> movieList = jsonList.map<MovieModel>((e) => MovieModel.fromJson(e)).toList();
      return Future.value(movieList);
    }else{
      throw EmptyCacheException(error: AppStrings.emptyCacheException);
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() {
    final jsonString = sharedPreferences.getString(AppStrings.cachedTopRated);
    if(jsonString !=null){
      List jsonList = json.decode(jsonString) as List;
      List<MovieModel> movieModelList = jsonList.map<MovieModel>((e) => MovieModel.fromJson(e)).toList();
      return Future.value(movieModelList);
    }else{
      throw EmptyCacheException(error: AppStrings.emptyCacheException);
    }
  }

}