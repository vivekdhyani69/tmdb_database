import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/domain/usecases/rate_movie_usecase.dart';
import 'package:movie_tmdb/presentation/blocs/movie_ratings/movie_rating_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_ratings/movie_rating_state.dart';

class MovieRatingBloc extends Bloc<MovieRatingEvent, MovieRatingState> {
  final RateMovieUsecase rateMovieUsecase;

  MovieRatingBloc(this.rateMovieUsecase) : super(MovieRatingInitial()) {
    on<SubmitRatingEvent>((event, emit) async {
      emit(MovieRatingSubmitting()); // Loading state
      try {
        await rateMovieUsecase.call(event.movieId, event.rating);
        emit(MovieRatingSuccess(message: 'Rating submitted successfully'));
      } catch (e) {
        emit(MovieRatingError(errorMessage: e.toString()));
      }
    });
  }
}
