abstract class MovieDetailsEvent{}

class FetchMovieDetailsEvent extends MovieDetailsEvent {
  final int movieId;
  FetchMovieDetailsEvent(this.movieId);
}


//In this has only one event in which bases we fetched the details