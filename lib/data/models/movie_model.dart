import 'package:flutter/foundation.dart';
import 'package:movie_tmdb/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.id,
    required super.overview,
    required super.poster_path,
    required super.title,
    required super.release_date,
    required super.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      overview: json['overview'],
      poster_path: json['poster_path'],
      title: json['title'],
      release_date: json['release_date'],
      voteAverage: json['vote_average'].toString(),
    );
  }
}


////firstlly creates the entity and model it means the variable data which is in api response