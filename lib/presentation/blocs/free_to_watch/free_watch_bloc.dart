import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/data/models/freeWatch_model.dart';
import 'package:movie_tmdb/domain/entities/free_watch_entity.dart';
import 'package:movie_tmdb/domain/repositories/movie_repository.dart';
import 'package:movie_tmdb/domain/usecases/free_watch_movie_useCase.dart';
import 'package:movie_tmdb/presentation/blocs/free_to_watch/free_watch_event.dart';
import 'package:movie_tmdb/presentation/blocs/free_to_watch/free_watch_state.dart';

class FreeWatchBloc extends Bloc<FreeWatchEvent, FreeWatchState> {
  // final MovieRepository movieRepository; //this is inject dependency object
  final FreeWatchMovieUsecase
  getFreeWatchMovies; //this is inject dependency object
  FreeWatchBloc(this.getFreeWatchMovies) : super(FreeWatchInitial()) {
    on<FetchFreeWatchEvent>((event, emit) async {
      emit(FreeWatchLoading());

      try {
        // final freeWatchMovies = [
        //   FreeWatchEntity(
        //     id: 1,
        //     name: 'Movie 1',
        //     imageUrl: 'https://example.com/movie1.jpg',
        //     description: 'Description of Movie 1',
        //     releaseDate: '2023-01-01',
        //     rating: '8.5',
        //   ),
        //   FreeWatchEntity(
        //     id: 2,
        //     name: 'Movie 2',
        //     imageUrl: 'https://example.com/movie2.jpg',
        //     description: 'Description of Movie 2',
        //     releaseDate: '2023-02-01',
        //     rating: '7.5',
        //   ),
        // ];

        final freeWatchMovies = await getFreeWatchMovies.execute();

        ///calls the api and returns the list of free watch movies

        emit(FreeWatchLoaded(freeWatchMovies));
      } catch (e) {
        emit(FreeWatchError('Failed to fetch free watch movies'));
      }
    });
  }
}
