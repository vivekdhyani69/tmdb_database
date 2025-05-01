import 'package:movie_tmdb/data/models/freeWatch_model.dart';
import 'package:movie_tmdb/domain/entities/free_watch_entity.dart';
import 'package:movie_tmdb/domain/repositories/movie_repository.dart';

class FreeWatchMovieUsecase {
  ///In this useCase we only calls the methods of repository calls the api
  final MovieRepository movieRepository;

  FreeWatchMovieUsecase(this.movieRepository);

  Future<List<FreeWatchEntity>> execute() async {
    return await movieRepository.getFreeWatchMovies();
  }
}
