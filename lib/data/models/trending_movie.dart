import 'package:movie_tmdb/domain/entities/trendingMovie_entity.dart';

class TrendingMovieModel extends TrendingMovie {
  TrendingMovieModel({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.backdropPath,
    required super.voteAverage,
    required super.releaseDate,
    required super.original_title,
    required super.overview,
  });

  ///Now we converts a Json object  into a dart object model

  factory TrendingMovieModel.fromJson(Map<String, dynamic> json) {
    return TrendingMovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: json['vote_average'] ?? '',
      releaseDate: json['release_date'] ?? '',
      original_title: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
    );
  }
}
