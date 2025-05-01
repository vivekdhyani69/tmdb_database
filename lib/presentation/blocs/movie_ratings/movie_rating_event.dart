abstract class MovieRatingEvent {}

class SubmitRatingEvent extends MovieRatingEvent {
  ///submit rating event
  ///This is the event which is used to submit the rating of a movie this is the event which is used to submit the rating of a movie
  final int movieId;
  final double rating;

  SubmitRatingEvent({required this.movieId, required this.rating});
}
