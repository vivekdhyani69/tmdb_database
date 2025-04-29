import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/domain/usecases/search_movies.dart';
import 'package:movie_tmdb/presentation/blocs/search_bloc/search_event.dart';
import 'package:movie_tmdb/presentation/blocs/search_bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;

  SearchBloc(this.searchMovies) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) async {
      if (event.query.trim().isEmpty) return;
      emit(SearchLoading());
      try {
        final results = await searchMovies.call(
          event.query,
        ); //inside this the data in comes from  Ui in events the data is comes from Ui and pass the function who is returns the list of data

        emit(SearchLoaded(results));
      } catch (error) {
        emit(SearchError(error.toString()));
      }
    });
  }
}
