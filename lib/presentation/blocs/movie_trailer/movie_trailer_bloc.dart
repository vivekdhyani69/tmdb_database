// presentation/bloc/movie_trailer_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:movie_tmdb/domain/usecases/get_movie_trailer.dart';
import 'movie_trailer_event.dart';
import 'movie_trailer_state.dart';

class MovieTrailerBloc extends Bloc<MovieTrailerEvent, MovieTrailerState> {
  final GetMovieTrailer getMovieTrailers;

  MovieTrailerBloc({required this.getMovieTrailers})
    : super(MovieTrailerInitial()) {
    on<FetchMovieTrailersEvent>((event, emit) async {
      emit(MovieTrailerLoading());
      try {
        final trailers = await getMovieTrailers.execute(event.movieId);
        emit(MovieTrailerLoaded(trailers));
      } catch (e) {
        emit(MovieTrailerError(e.toString()));
      }
    });
  }
}
