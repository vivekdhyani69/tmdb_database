import 'package:movie_tmdb/domain/repositories/movie_repository.dart';

class GetUserMovieRatingUsecase {
  final MovieRepository movieRepository;

  GetUserMovieRatingUsecase(this.movieRepository);

  Future<double> call(int movieId) async {
    return movieRepository.getUserRating(movieId);
  }
}
