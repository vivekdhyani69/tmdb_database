class FreeWatchEntity {
  final int id;
  final String title;
  final String poster_path;
  final String overview;
  final String release_date;
  final double vote_average;

  FreeWatchEntity({
    required this.id,
    required this.title,
    required this.poster_path,
    required this.overview,
    required this.release_date,
    final this.vote_average = 0.0,
  });
}
