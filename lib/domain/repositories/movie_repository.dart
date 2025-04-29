import 'package:movie_tmdb/domain/entities/movie_entity.dart';
import 'package:movie_tmdb/domain/entities/search_entity.dart';
import 'package:movie_tmdb/domain/entities/trailerModel_entity.dart';
import 'package:movie_tmdb/domain/entities/trendingMovie_entity.dart';

///This is the abstraction. It defines what can be done there not how ??
abstract class MovieRepository {
  Future<List<TrendingMovie>> getTrendingMovies();

  Future<List<TrailerModel>> getTrailersMovies(int movieId);

  Future<List<SearchEntity>> getSearchMovies(String query);
  Future<MovieEntity> getMovieById(int id);

}



///divides the domain as per repo sounds like