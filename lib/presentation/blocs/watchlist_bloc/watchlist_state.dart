import 'package:movie_tmdb/domain/entities/movie_entity.dart';

abstract class WatchlistState {}

class WatchlistInitalState extends WatchlistState {}

class WatchlistLoadingState extends WatchlistState {}

class WatchlistSuccessState extends WatchlistState {}

class WatchlistErrorState extends WatchlistState {
  final String message;
  WatchlistErrorState({required this.message});
}

class WatchListLoadedState extends WatchlistState {
  final List<MovieEntity> watchList;
  WatchListLoadedState({required this.watchList});
}
