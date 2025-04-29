import 'package:movie_tmdb/domain/entities/popularPerson_entity.dart';

class PopularpersonsModels extends PopularpersonEntity {
  PopularpersonsModels({
    required super.id,
    required super.name,
    required super.profilePath,
  });

  factory PopularpersonsModels.fromJson(Map<String, dynamic> json) {
    return PopularpersonsModels(
      id: json['id'],
      name: json['name'] ?? 'Unknown',
      profilePath: json['profile_path'] ?? '',
    );
  }
}
