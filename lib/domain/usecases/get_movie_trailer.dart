//The use case encapsulates the action of fetching movie trailers. This makes it easier to maintain and test your business logic.

import 'package:movie_tmdb/domain/entities/trailerModel_entity.dart';
import 'package:movie_tmdb/domain/repositories/movie_repository.dart';

class GetMovieTrailer {
  final MovieRepository movieRepository;
  GetMovieTrailer({required this.movieRepository});

  Future<List<TrailerModel>> execute(int movieId) async {
    //makes an function which is returns
    //Executes tje action  of getting trailer
    return await movieRepository.getTrailersMovies(movieId);
  }
}

//Main we pased the repositoty where api presents  to the UseCases
