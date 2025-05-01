import 'package:movie_tmdb/domain/entities/movie_entity.dart';

abstract class MovieDetailsEvent {}

class FetchMovieDetailsEvent extends MovieDetailsEvent {
  final int movieId;
  FetchMovieDetailsEvent(this.movieId);
}
