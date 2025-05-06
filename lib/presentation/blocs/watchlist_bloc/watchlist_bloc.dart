import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/domain/entities/movie_entity.dart';
import 'package:movie_tmdb/domain/usecases/add_watchlist_usecase.dart';
import 'package:movie_tmdb/domain/usecases/get_movie_list_usecase.dart';
import 'package:movie_tmdb/presentation/blocs/watchlist_bloc/watchlist_event.dart';
import 'package:movie_tmdb/presentation/blocs/watchlist_bloc/watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchListEvent, WatchlistState> {
  final AddWatchlistUseCase addWatchlistUseCase;
  final GetWatchlistUseCase getWatchlistUseCase;
  WatchlistBloc({
    required this.addWatchlistUseCase,
    required this.getWatchlistUseCase,
  }) : super(WatchlistInitalState()) {
    on<AddWatchListEvent>(_addWatchListEvent);
    on<fetchWatchListEvent>(_fetchWatchListEvent);
  }

  Future<void> _addWatchListEvent(
    AddWatchListEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(WatchlistLoadingState());

    ///emits loading state
    try {
      //calling the useCase to add the watchList
      final result = await addWatchlistUseCase.execute(
        event.movieId,
        event.isWatchList,
      );
    } catch (e) {
      emit(WatchlistErrorState(message: e.toString()));
    }
  }

  Future<void> _fetchWatchListEvent(
    fetchWatchListEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(WatchlistLoadingState());
    try {
      final movies = await getWatchlistUseCase.execute();
      emit(WatchListLoadedState(watchList: movies));
    } catch (e) {
      print('Error fetching watchlist: $e');
      emit(WatchlistErrorState(message: e.toString()));
    }
  }
}
