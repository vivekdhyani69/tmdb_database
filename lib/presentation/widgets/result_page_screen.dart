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
//     final args = ModalRoute.of(context)?.settings.arguments as Map;
// final movieId = int.parse(args['id']);
context.read<MovieDetailBloc>().add(FetchMovieDetailsEvent( movieId));

    return Scaffold(
      appBar: AppBar(title : Text('Movie Details ${movieId}')),
      body: BlocBuilder<MovieDetailBloc,MovieDetailsState>(builder: (context,state){
        if(state is MovieDetailsLoading){
          return Center(child: CircularProgressIndicator(),);
          
        }
        else if(state is MovieDetailsLoaded){
    final movie =state.movie;
    return ListView(
      children: [
        ListTile(
          title: Text(movie.title),
          subtitle: Text(movie.overview),
        )
    ]);
        }
        else{
          return Text('Error');
        }
      } ),
    );
  }


}
