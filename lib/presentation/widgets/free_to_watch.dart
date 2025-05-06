import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/free_to_watch/free_watch_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/free_to_watch/free_watch_event.dart';
import 'package:movie_tmdb/presentation/blocs/free_to_watch/free_watch_state.dart';
import 'package:movie_tmdb/presentation/blocs/movie_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_state.dart';

class FreeToWatch extends StatefulWidget {
  const FreeToWatch({super.key});

  @override
  State<FreeToWatch> createState() => _FreeToWatchState();
}

class _FreeToWatchState extends State<FreeToWatch> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<FreeWatchBloc>().add(FetchFreeWatchEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dispatch the event to fetch free watch movies

    return SizedBox(
      height: 370,
      child: BlocBuilder<FreeWatchBloc, FreeWatchState>(
        builder: (context, state) {
          if (state is FreeWatchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FreeWatchLoaded) {
            final movies = state.freeWatchMovies;

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
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the movie details screen
                        // Navigator.pushNamed(
                        //   context,
                        //   '/movie_details',
                        //   arguments: {'id': movie.id}, // or just pass int
                        // );
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
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w500${movie.poster_path}",
                                        height: 210,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
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
                                    "${(movie.vote_average * 10).toInt()}%",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 11,
                              right: 20,
                              child: PopupMenuButton<int>(
                                icon: Icon(
                                  Icons.more_horiz_rounded,
                                  color: Colors.white,
                                ),
                                onSelected: (value) {
                                  // handle menu actions
                                },
                                itemBuilder:
                                    (context) => [
                                      const PopupMenuItem(
                                        value: 0,
                                        child: Row(
                                          children: [
                                            Icon(Icons.add_circle_outline),
                                            SizedBox(width: 8),
                                            Text("Add to List"),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            Icon(Icons.favorite_outline),
                                            SizedBox(width: 8),
                                            Text("Favorite"),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: 2,
                                        child: Row(
                                          children: [
                                            Icon(Icons.watch_later_outlined),
                                            SizedBox(width: 8),
                                            Text("Watchlist"),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: 3,
                                        child: Row(
                                          children: [
                                            Icon(Icons.star),
                                            SizedBox(width: 8),
                                            Text("Rate Movie"),
                                          ],
                                        ),
                                      ),
                                    ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is FreeWatchError) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else {
            return Container(
              child: Center(
                child: Text(
                  'No Movies Found',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
