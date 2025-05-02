import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/core/routes/app_routes.dart';
import 'package:movie_tmdb/data/repositories/movie_repository_impl.dart';
import 'package:movie_tmdb/data/repositories/people_repository_impl.dart';
import 'package:movie_tmdb/domain/usecases/free_watch_movie_usecase.dart';
import 'package:movie_tmdb/domain/usecases/get_movie_by_id_usecase.dart';

import 'package:movie_tmdb/domain/usecases/get_movie_trailer.dart';
import 'package:movie_tmdb/domain/usecases/get_user_movie_rating_usecase.dart';
import 'package:movie_tmdb/domain/usecases/rate_movie_usecase.dart';
import 'package:movie_tmdb/domain/usecases/search_movies.dart';
import 'package:movie_tmdb/presentation/blocs/free_to_watch/free_watch_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_details/movie_details_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_ratings/movie_rating_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/popular_people/people_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/popular_people/people_event.dart';
import 'package:movie_tmdb/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/search_bloc/search_event.dart';
import 'package:movie_tmdb/presentation/screens/home_screen.dart';

void main() {
  final movieRepository = MovieRepositoryImpl(); // only created once
  final peopleRepository = PeopleRepositoryImpl();
  final getMovieByIdUseCase = GetMovieByIdUseCase(movieRepository);
  final getFreeWatchMovies = FreeWatchMovieUsecase(
    movieRepository,
  ); // Pass this to the bloc
  final rateMovieUsecase = RateMovieUsecase(movieRepository);
  final getUserMovieRatingUsecase = GetUserMovieRatingUsecase(movieRepository);

  final searchMovie = SearchMovies(
    movieRepository,
  ); //it returns a list of movies based on the search query
  runApp(
    MultiRepositoryProvider(
      //With the help of this we can access repository and and use cases anywhere in the app
      providers: [
        RepositoryProvider.value(value: movieRepository),
        RepositoryProvider(
          create: (_) => GetMovieTrailer(movieRepository: movieRepository),
        ),
      ],

      child: MultiBlocProvider(
        providers: [
          BlocProvider<MovieBloc>(
            create:
                (context) =>
                    MovieBloc(movieRepository)..add(FetchTrendingMoviesEvent()),
          ),
          BlocProvider<PeopleBloc>(
            create:
                (context) => PeopleBloc(peopleRepository)..add(FetchPeople(1)),
          ),
          BlocProvider<SearchBloc>(
            create:
                (context) =>
                    SearchBloc(searchMovie)..add(SearchQueryChanged('')),
          ),
          BlocProvider<MovieDetailBloc>(
            create: (context) => MovieDetailBloc(getMovieByIdUseCase),
          ),
          BlocProvider<FreeWatchBloc>(
            create: (context) => FreeWatchBloc(getFreeWatchMovies),
          ),
          BlocProvider<MovieRatingBloc>(
            create:
                (context) => MovieRatingBloc(
                  rateMovieUsecase: rateMovieUsecase,
                  getUserMovieRatingUsecase: getUserMovieRatingUsecase,
                ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const HomePage(),
      initialRoute: '/',
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
