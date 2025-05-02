abstract class MovieRatingState {}

class MovieRatingInitial extends MovieRatingState {}

class MovieRatingSubmitting extends MovieRatingState {
  ////we accept these 2 values from the Ui user amd then we pass tot the event which is in the bloc
}

class MovieRatingSuccess extends MovieRatingState {
  final String message;
  MovieRatingSuccess({required this.message});
}

class MovieRatingLoaded extends MovieRatingState {
  ///why this state accepts this rating  value from the ui and then we pass it to the event which is in the bloc
  ///this is the state which is used to load the rating of a movie this is the state which is used to load the rating of a movie
  final double rating;
  final int movieId;
  MovieRatingLoaded({required this.rating, required this.movieId});
}

class MovieRatingError extends MovieRatingState {
  final String errorMessage;
  MovieRatingError({required this.errorMessage});
}
