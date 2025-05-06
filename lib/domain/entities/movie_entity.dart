class MovieEntity {
  final int id;
  final String title;
  final String overview;
  final String poster_path;
  final String? release_date;
  final String? voteAverage;

  MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.poster_path,
    required this.release_date,
    required this.voteAverage,
  });
}
