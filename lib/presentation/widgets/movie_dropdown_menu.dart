import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_ratings/movie_rating_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_ratings/movie_rating_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_ratings/movie_rating_state.dart';
import 'package:movie_tmdb/presentation/blocs/watchlist_bloc/watchlist_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/watchlist_bloc/watchlist_event.dart';
import 'package:movie_tmdb/presentation/screens/show_watchlist.dart';

class MovieOptionsMenu extends StatefulWidget {
  final int movieId;
  final double voteAverage;

  const MovieOptionsMenu({
    super.key,
    required this.movieId,
    required this.voteAverage,
  });

  @override
  State<MovieOptionsMenu> createState() => _MovieOptionsMenuState();
}

class _MovieOptionsMenuState extends State<MovieOptionsMenu> {
  bool showRating = false;
  bool tapWatchlist = false;
  bool tapFavorite = false;
  final Map<int, int> movieratings = {};

  @override
  void initState() {
    super.initState();

    context.read<MovieRatingBloc>().add(
      FetchRatingEvent(movieId: widget.movieId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieRatingBloc, MovieRatingState>(
      listener: (context, state) {
        if (state is MovieRatingLoaded && state.movieId == widget.movieId) {
          setState(() {
            movieratings[state.movieId] = (state.rating / 2).round();
          });
        }
      },
      child: PopupMenuButton<int>(
        icon: const Icon(Icons.more_horiz_rounded, color: Colors.white),
        onSelected: (value) {
          if (value == 0) {
            print("Add to List - ${widget.movieId}");
          } else if (value == 1) {
            print("Favorite - ${widget.movieId}");
          }
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
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.favorite_outline),
                    SizedBox(width: 8),
                    Text("Favorite"),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                enabled: false, // prevents automatic selection
                child: StatefulBuilder(
                  builder:
                      (context, setState) => InkWell(
                        onTap: () {
                          context.read<WatchlistBloc>().add(
                            AddWatchListEvent(
                              movieId: widget.movieId,
                              isWatchList: !tapWatchlist,
                            ),
                          );

                          setState(() {
                            tapWatchlist = !tapWatchlist;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                tapWatchlist
                                    ? "Added to Watchlist"
                                    : "Removed from Watchlist",
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              tapWatchlist
                                  ? Icons.watch_later
                                  : Icons.watch_later_outlined,
                            ),
                            const SizedBox(width: 8),
                            const Text("Watchlist"),
                          ],
                        ),
                      ),
                ),
              ),

              const PopupMenuDivider(),
              PopupMenuItem(
                value: -1,
                enabled: true,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop(); // Close menu
                    showDialog(
                      context: context,
                      builder: (context) {
                        // Initializing the rating from the global state
                        int localSelected = movieratings[widget.movieId] ?? 0;

                        return AlertDialog(
                          title: const Text("Rate this Movie"),
                          content: StatefulBuilder(
                            builder: (context, localSetState) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  return IconButton(
                                    icon: Icon(
                                      index < localSelected
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                    ),
                                    onPressed: () {
                                      localSetState(() {
                                        localSelected = index + 1;
                                      });

                                      context.read<MovieRatingBloc>().add(
                                        SubmitRatingEvent(
                                          movieId: widget.movieId,
                                          rating: (index + 1) * 2.0,
                                        ),
                                      );

                                      // Fetch updated rating after submission
                                      context.read<MovieRatingBloc>().add(
                                        FetchRatingEvent(
                                          movieId: widget.movieId,
                                        ),
                                      );
                                    },
                                  );
                                }),
                              );
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Close"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        (movieratings[widget.movieId] ?? 0) > 0
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 8),
                      const Text("Your Rating"),
                    ],
                  ),
                ),
              ),
            ],
      ),
    );
  }
}
