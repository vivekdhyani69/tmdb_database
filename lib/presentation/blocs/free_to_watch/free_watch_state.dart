import 'package:movie_tmdb/domain/entities/free_watch_entity.dart';

abstract class FreeWatchState {}

class FreeWatchInitial extends FreeWatchState {}

class FreeWatchLoading extends FreeWatchState {}

class FreeWatchLoaded extends FreeWatchState {
  final List<FreeWatchEntity> freeWatchMovies;
  FreeWatchLoaded(this.freeWatchMovies);
}

class FreeWatchError extends FreeWatchState {
  final String error;
  FreeWatchError(this.error);
}
