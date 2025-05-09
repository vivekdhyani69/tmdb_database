import 'package:movie_tmdb/domain/repositories/movie_repository.dart';
import 'package:movie_tmdb/presentation/blocs/movie_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository; //this is inject dependency object

  MovieBloc(this.movieRepository) : super(MovieInitial()) {
    on<FetchTrendingMoviesEvent>((event, emit) async {
      ///Alternative of View Model
      emit(MovieLoading());

      try {
        final movie = await movieRepository.getTrendingMovies();

        ///this returns the array of object of movies

        emit(MovieLoaded(movie));
      } catch (e) {
        // emit(MovieError(e.toString()));
      }
    });
  }
}
