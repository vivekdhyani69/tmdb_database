import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:movie_tmdb/core/routes/route_names.dart';
import 'package:movie_tmdb/presentation/blocs/movie_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_ratings/movie_rating_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_ratings/movie_rating_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_state.dart';
import 'package:movie_tmdb/presentation/widgets/movie_dropdown_menu.dart';
import 'package:movie_tmdb/presentation/widgets/movie_trailer_screen.dart';

class MovieCardList extends StatefulWidget {
  MovieCardList({super.key});

  @override
  State<MovieCardList> createState() => _MovieCardListState();
}

class _MovieCardListState extends State<MovieCardList> {
  bool showRating = false; // in your widget state
  int selectedRating = 0;
  // bool showRating = false;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(FetchTrendingMoviesEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 410,
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            final movies = state.movies;

            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Scrollbar(
                thumbVisibility: true, // always show scrollbar
                trackVisibility: true, // optional
                controller: _scrollController, // defined below

                child: ListView.builder(
                  controller: _scrollController, // defined below
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];

                    ///one by one every movie data object comes here

                    return GestureDetector(
                      onTap: () {
                        // Navigate to the movie details screen
                        Navigator.pushNamed(
                          context,
                          RouteNames.trailer,
                          arguments: {'id': movie.id}, // or just pass int
                        );
                      },
                      child: Container(
                        width: 160,
                        margin: const EdgeInsets.only(right: 16),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Card(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                        height: 210,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  movie.releaseDate,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 190,
                              left: 10,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                    color: Colors.greenAccent,
                                    width: 3,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "${(movie.voteAverage * 10).toInt()}%",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            MovieOptionsMenu(
                              movieId: movie.id,
                              voteAverage: movie.voteAverage,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }

          return const Text("Something went wrong.");
        },
      ),
    );
  }
}
