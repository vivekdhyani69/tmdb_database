import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_ratings/movie_rating_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_ratings/movie_rating_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_ratings/movie_rating_state.dart';

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
  int selectedRating = 0;

  @override
  void initState() {
    super.initState();

    // Default value in case API fails
    selectedRating = (widget.voteAverage / 2).round();

    // Fetch user's actual rating
    context.read<MovieRatingBloc>().add(
      FetchRatingEvent(movieId: widget.movieId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieRatingBloc, MovieRatingState>(
      listener: (context, state) {
        if (state is MovieRatingLoaded) {
          setState(() {
            selectedRating = (state.rating / 2).round();
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
          } else if (value == 2) {
            print("Watchlist - ${widget.movieId}");
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
              const PopupMenuDivider(),
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
              const PopupMenuDivider(),
              PopupMenuItem(
                value: -1,
                enabled: true,
                child: StatefulBuilder(
                  builder: (context, localSetState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            localSetState(() {
                              showRating = !showRating;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                showRating ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 8),
                              const Text("Your Rating"),
                            ],
                          ),
                        ),
                        if (showRating)
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(5, (index) {
                                return IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: Icon(
                                    index < selectedRating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.amber,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    localSetState(() {
                                      selectedRating = index + 1;
                                    });

                                    context.read<MovieRatingBloc>().add(
                                      SubmitRatingEvent(
                                        movieId: widget.movieId,
                                        rating:
                                            (index + 1) * 2.0, // Scale to 10
                                      ),
                                    );

                                    Navigator.of(context).pop();
                                  },
                                );
                              }),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
      ),
    );
  }
}
