import 'package:movie_tmdb/domain/entities/search_entity.dart';
import 'package:movie_tmdb/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository movieRepository;
  SearchMovies(this.movieRepository);

  Future<List<SearchEntity>> call(String query) {
    return movieRepository.getSearchMovies(query);

    ///inside this we passed the value to api and then returns function gives the data to call methods
  }
}
