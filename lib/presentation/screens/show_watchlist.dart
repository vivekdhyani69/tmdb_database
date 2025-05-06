import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/watchlist_bloc/watchlist_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/watchlist_bloc/watchlist_event.dart';
import 'package:movie_tmdb/presentation/blocs/watchlist_bloc/watchlist_state.dart';

class ShowWatchlist extends StatefulWidget {
  const ShowWatchlist({super.key});

  @override
  State<ShowWatchlist> createState() => _ShowWatchlistState();
}

class _ShowWatchlistState extends State<ShowWatchlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
      ),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Loading Watchlist...'),
                ],
              ),
            );
          } else if (state is WatchListLoadedState) {
            return ListView.builder(
              itemCount: state.watchList.length,
              itemBuilder: (context, index) {
                final movie = state.watchList[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading:
                        movie.poster_path != null
                            ? Image.network(
                              'https://image.tmdb.org/t/p/w92${movie.poster_path}', // w92, w154, w342, etc.
                              fit: BoxFit.cover,
                            )
                            : const Icon(Icons.movie),
                    title: Text(
                      movie.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          "Release Date: ${movie.release_date}",
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          movie.overview,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Text(
                          movie.voteAverage.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Optionally navigate to movie details screen
                    },
                  ),
                );
              },
            );
          } else if (state is WatchlistErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 20),
                  Text('Error: ${state.message}'),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No Watchlist Found'));
          }
        },
      ),
    );
  }
}
