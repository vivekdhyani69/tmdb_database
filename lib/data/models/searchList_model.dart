import 'package:movie_tmdb/domain/entities/search_entity.dart';

class SearchlistModel extends SearchEntity {
  SearchlistModel({
    required super.id,
    required super.title,
    required super.posterPath,
  });

  factory SearchlistModel.fromJson(Map<String, dynamic> json) {
    return SearchlistModel(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      posterPath: json['posterPath'] ?? "",
    );
  }
}
