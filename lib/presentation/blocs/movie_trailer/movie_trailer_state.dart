// presentation/bloc/movie_trailer_state.dart
import 'package:equatable/equatable.dart';
import 'package:movie_tmdb/domain/entities/trailerModel_entity.dart';

abstract class MovieTrailerState extends Equatable {
  const MovieTrailerState();
  @override
  List<Object> get props => [];
}

class MovieTrailerInitial extends MovieTrailerState {}

class MovieTrailerLoading extends MovieTrailerState {}

class MovieTrailerLoaded extends MovieTrailerState {
  final List<TrailerModel> trailers;
  const MovieTrailerLoaded(this.trailers);

  @override
  List<Object> get props => [trailers];
}

class MovieTrailerError extends MovieTrailerState {
  final String message;
  const MovieTrailerError(this.message);

  @override
  List<Object> get props => [message];
}
