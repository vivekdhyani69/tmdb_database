// presentation/bloc/movie_trailer_event.dart
import 'package:equatable/equatable.dart';

abstract class MovieTrailerEvent extends Equatable {
  const MovieTrailerEvent();
  @override
  List<Object> get props => [];
}

class FetchMovieTrailersEvent extends MovieTrailerEvent {
  final int movieId;
  const FetchMovieTrailersEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
