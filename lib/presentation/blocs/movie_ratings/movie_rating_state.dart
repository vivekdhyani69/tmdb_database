abstract class MovieRatingState {}

class MovieRatingInitial extends MovieRatingState {}

class MovieRatingSubmitting extends MovieRatingState {
  ////we accept these 2 values from the Ui user amd then we pass tot the event which is in the bloc
}

class MovieRatingSuccess extends MovieRatingState {
  final String message;
  MovieRatingSuccess({required this.message});
}

class MovieRatingError extends MovieRatingState {
  final String errorMessage;
  MovieRatingError({required this.errorMessage});
}
