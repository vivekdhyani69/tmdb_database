import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_details/movie_details_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_details/movie_details_state.dart';
import 'package:movie_tmdb/presentation/blocs/movie_state.dart';

class ResultPageScreen extends StatelessWidget {
  final int movieId;
  ResultPageScreen({required this.movieId});
  @override
  Widget build(BuildContext context) {
    context.read<MovieDetailBloc>().add(FetchMovieDetailsEvent(movieId));

    return Scaffold(
      appBar: AppBar(title: Text('Movie Id Number ${movieId}')),
      body: BlocBuilder<MovieDetailBloc, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailsLoaded) {
            final movie = state.movie;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "https://image.tmdb.org/t/p/w200/${movie.poster_path}",
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 8),

                        Text(movie.overview),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('Error');
          }
        },
      ),
    );
  }
}
