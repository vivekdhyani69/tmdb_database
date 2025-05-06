import 'package:movie_tmdb/domain/repositories/movie_repository.dart';

class AddWatchlistUseCase {
  final MovieRepository movieRepository;

  AddWatchlistUseCase(this.movieRepository);

  Future<bool> execute(int movieId, bool isWatchList) async {
    return await movieRepository.addWatchList(movieId, isWatchList);
  }
}
