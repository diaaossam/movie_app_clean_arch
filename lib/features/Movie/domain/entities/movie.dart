import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String backdropPath;
  final List<int> genres;
  final String overview;
  final double voteAverage;
  final String releaseData;

  const Movie({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.genres,
    required this.overview,
    required this.voteAverage,
    required this.releaseData,
  });

  @override
  List<Object> get props => [id, title, backdropPath, genres, overview, voteAverage,releaseData];

}
