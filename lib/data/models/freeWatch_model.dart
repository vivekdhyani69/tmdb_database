import 'package:movie_tmdb/domain/entities/free_watch_entity.dart';

class FreewatchModel extends FreeWatchEntity {
  FreewatchModel({
    required super.id,
    required super.title,
    required super.poster_path,
    required super.overview,
    required super.release_date,
    required super.vote_average,
  });

  factory FreewatchModel.fromJson(Map<String, dynamic> json) {
    return FreewatchModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      poster_path: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      release_date: json['release_date'] ?? '',
      vote_average: json['vote_average'] ?? 0.0,
    );
  }
}
