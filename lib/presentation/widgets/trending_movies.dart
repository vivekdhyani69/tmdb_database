import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:movie_tmdb/core/routes/route_names.dart';
import 'package:movie_tmdb/presentation/blocs/movie_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_state.dart';
import 'package:movie_tmdb/presentation/widgets/movie_trailer_screen.dart';

class MovieCardList extends StatelessWidget {
  // Sample movie data list
  final List<Map<String, dynamic>> movies = [
    {
      'title': "The Last of Us",
      'imageUrl':
          'https://th.bing.com/th/id/OIP.c0dbeET9s0PH-r03RI9t-gHaDV?w=4000&h=1804&rs=1&pid=ImgDetMain',
      'releaseDate': "Jan 15, 2023",
      'rating': 86,
    },
    {
      'title': "Breaking Bad",
      'imageUrl':
          'https://th.bing.com/th/id/OIP.c0dbeET9s0PH-r03RI9t-gHaDV?w=4000&h=1804&rs=1&pid=ImgDetMain',
      'releaseDate': "Jan 20, 2008",
      'rating': 95,
    },
    {
      'title': "Stranger Things",
      'imageUrl':
          'https://th.bing.com/th/id/OIP.c0dbeET9s0PH-r03RI9t-gHaDV?w=4000&h=1804&rs=1&pid=ImgDetMain',
      'releaseDate': "July 15, 2016",
      'rating': 88,
    },
  ];

  MovieCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            final movies = state.movies;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                ///one by one every movie data object comes here

                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder:
                    //         (_) => MovieTrailerScreen(
                    //           movieId: movie.id,
                    //         ), // Pass movieId here
                    //   ),
                    // )
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
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                  height: 210,
                                  fit: BoxFit.cover,
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
                        Positioned(
                          top: 11,
                          right: 20,
                          child: PopupMenuButton<int>(
                            icon: Icon(
                              Icons.more_horiz_rounded,
                              color: Colors.white,
                            ),
                            onSelected: (value) {
                              if (value == 0) {
                                print("Add to List");
                              } else if (value == 1) {
                                print("Favorite");
                              } else if (value == 2) {
                                print("Watchlist");
                              } else if (value == 3) {
                                print("Your Rating");
                              }
                            },
                            itemBuilder:
                                (context) => [
                                  const PopupMenuItem(
                                    value: 0,
                                    child: Text("Add to List"),
                                  ),
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text("Favorite"),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: Text("Watchlist"),
                                  ),
                                  const PopupMenuItem(
                                    value: 3,
                                    child: Text("Your Rating"),
                                  ),
                                ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Text("Something went wrong.");
        },
      ),
    );
  }
}
