import 'package:movie_tmdb/domain/repositories/movie_repository.dart';

class RateMovieUsecase {
  final MovieRepository movieRepository;
  RateMovieUsecase(this.movieRepository);

  Future<void> call(int movieId, double rating) async {
    return movieRepository.rateMovie(movieId, rating);
  }
}
