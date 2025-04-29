import 'package:movie_tmdb/domain/entities/trailerModel_entity.dart';

class TrailerMovieModels extends TrailerModel {
  TrailerMovieModels({
    required super.id,
    required super.key,
    required super.name,
    required super.site,
    required super.type,
  });

  factory TrailerMovieModels.fromJson(Map<String, dynamic> json) {
    return TrailerMovieModels(
      id: json['id'] ?? '',
      key: json['key'] ?? '',
      name: json['name'] ?? '',
      site: json['site'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
