import 'package:movie_app_clean_arch/features/Movie/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel(
      {required super.id,
      required super.title,
      required super.backdropPath,
      required super.genres,
      required super.overview,
      required super.voteAverage,
      required super.releaseData});



  factory MovieModel.fromJson(Map<String, dynamic> json)=>
      MovieModel(
          id: json['id'],
          title: json['title'],
          backdropPath: json['backdrop_path'],
          genres: List<int>.from(json['genre_ids'].map((e) =>e)),
          overview: json['overview'],
          voteAverage: json['vote_average'].toDouble(),
          releaseData: json['release_date'],
      );

  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "title":title,
      "backdrop_path":backdropPath,
      "genre_ids":genres,
      "overview":overview,
      "vote_average":voteAverage,
      "release_date":releaseData,
    };
  }
}
