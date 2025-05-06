abstract class WatchListEvent {}

class AddWatchListEvent extends WatchListEvent {
  final int movieId;
  final bool isWatchList;
  AddWatchListEvent({required this.movieId, required this.isWatchList});
}

class fetchWatchListEvent extends WatchListEvent {}
