import 'package:movie_tmdb/domain/entities/movie_entity.dart';
import 'package:movie_tmdb/domain/repositories/movie_repository.dart';

class GetMovieByIdUseCase {
    final MovieRepository repository;

    GetMovieByIdUseCase(this.repository);

    Future<MovieEntity> call(int id)async {
      return await repository.getMovieById(id);
    }
}