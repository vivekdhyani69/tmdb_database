// presentation/pages/movie_trailer_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/domain/usecases/get_movie_trailer.dart';
import 'package:movie_tmdb/presentation/blocs/movie_trailer/movie_trailer_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_trailer/movie_trailer_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_trailer/movie_trailer_state.dart';
import 'package:movie_tmdb/presentation/widgets/trailer_player.dart';

class MovieTrailerScreen extends StatelessWidget {
  final int? id;
  const MovieTrailerScreen({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    
      create:
          (context) => MovieTrailerBloc(
            //ALways Ui to bloc data is gone
            getMovieTrailers:
                context
                    .read<
                      GetMovieTrailer
                    >(), //we access there getMovieTrailers ,because we defines it globally
          )..add(FetchMovieTrailersEvent(movieId: id!)),
      child: Scaffold(
        appBar: AppBar(title: Text('Trailers')),
        body: BlocBuilder<MovieTrailerBloc, MovieTrailerState>(
          //that is listens the state and rebuilds the Ui immediately
          builder: (context, state) {
            if (state is MovieTrailerLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MovieTrailerLoaded) {
              return ListView.builder(
                itemCount: state.trailers.length,
                itemBuilder: (context, index) {
                  final trailer = state.trailers[index];

                  // Construct YouTube URL using the 'key'
                  final trailerUrl =
                      'https://www.youtube.com/watch?v=${trailer.key}';

                  return ListTile(
                    title: Text(trailer.name),
                    subtitle: Text(trailer.type),
                  );
                  // return YouTubeIframeScreen(
                  //   videoUrl: trailerUrl,
                  //   // title: trailer.name,
                  //   // type: trailer.type,
                  // );
                },
              );
            } else if (state is MovieTrailerError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
