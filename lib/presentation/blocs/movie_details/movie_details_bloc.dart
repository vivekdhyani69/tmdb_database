import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/domain/usecases/get_movie_by_id_usecase.dart';
import 'package:movie_tmdb/presentation/blocs/movie_details/movie_details_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_details/movie_details_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieByIdUseCase getMovieById;

  MovieDetailBloc(this.getMovieById) : super(MovieDetailsInitial()) {
    on<FetchMovieDetailsEvent>((event, emit) async {
      ///With the help of this we can register events
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
////Why we passings getMovieByIdUseCase here only ofr seperation of concerns ..Because now movieBloc  is not directly deal with dataSource like Api db operation
///It focusing only on Ui logic or state .Not business logic

//Always Ui dispatched an event and bloc listens to it and then emits new states as per dispatching Bloc
