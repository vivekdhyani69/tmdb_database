import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/domain/usecases/get_movie_by_id_usecase.dart';
import 'package:movie_tmdb/presentation/blocs/movie_details/movie_details_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_details/movie_details_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieByIdUseCase getMovieById;

  MovieDetailBloc(this.getMovieById) : super(MovieDetailsInitial()) {
    on<FetchMovieDetailsEvent>((event, emit) async {
      emit(MovieDetailsLoading());
      try {
        final movie = await getMovieById(event.movieId);
        emit(MovieDetailsLoaded(movie));
      } catch (e) {
        emit(MovieDetailsError('Failed to fetch movie details'));
      }
    });
  }
}
