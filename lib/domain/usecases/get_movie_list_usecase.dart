import 'package:movie_tmdb/domain/entities/movie_entity.dart';
import 'package:movie_tmdb/domain/repositories/movie_repository.dart';

class GetWatchlistUseCase {
  final MovieRepository repository;

  GetWatchlistUseCase(this.repository);

  Future<List<MovieEntity>> execute() async {
    return await repository.getWatchlist();
  }
}
