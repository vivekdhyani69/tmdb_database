import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/domain/usecases/get_movie_by_id_usecase.dart';
import 'package:movie_tmdb/domain/usecases/get_user_movie_rating_useCase.dart';
import 'package:movie_tmdb/domain/usecases/rate_movie_usecase.dart';
import 'package:movie_tmdb/presentation/blocs/movie_ratings/movie_rating_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_ratings/movie_rating_state.dart';

class MovieRatingBloc extends Bloc<MovieRatingEvent, MovieRatingState> {
  final RateMovieUsecase rateMovieUsecase;
  final GetUserMovieRatingUsecase getUserMovieRatingUsecase;

  // Inject both use cases in the constructor
  MovieRatingBloc({
    required this.rateMovieUsecase,
    required this.getUserMovieRatingUsecase,
  }) : super(MovieRatingInitial()) {
    on<SubmitRatingEvent>((event, emit) async {
      emit(MovieRatingSubmitting()); // Loading state
      try {
        await rateMovieUsecase.call(event.movieId, event.rating);
        emit(MovieRatingSuccess(message: 'Rating submitted successfully'));
      } catch (e) {
        emit(MovieRatingError(errorMessage: e.toString()));
      }
    });

    // Fetch Rating Event Handler
    on<FetchRatingEvent>((event, emit) async {
      emit(MovieRatingSubmitting()); // Loading state
      try {
        // Call GetUserMovieRatingUsecase to get the user's movie rating
        final rating = await getUserMovieRatingUsecase.call(event.movieId);
        emit(
          MovieRatingLoaded(rating: rating),
        ); // Assuming the rating is a double
      } catch (e) {
        emit(MovieRatingError(errorMessage: e.toString()));
      }
    });
  }
}
