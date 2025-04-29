import 'package:movie_tmdb/domain/entities/movie_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}


class MovieDetailsLoading  extends MovieDetailsState{}


class MovieDetailsLoaded extends MovieDetailsState{
  final MovieEntity movie;
  MovieDetailsLoaded(this.movie);

}

class MovieDetailsError extends MovieDetailsState{
  final String error;
  MovieDetailsError(this.error);
}