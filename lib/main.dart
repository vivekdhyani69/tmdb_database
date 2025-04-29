import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/core/routes/app_routes.dart';
import 'package:movie_tmdb/data/repositories/movie_repository_impl.dart';
import 'package:movie_tmdb/data/repositories/people_repository_impl.dart';
import 'package:movie_tmdb/domain/usecases/get_movie_by_id_usecase.dart';
import 'package:movie_tmdb/domain/usecases/get_movie_trailer.dart';
import 'package:movie_tmdb/domain/usecases/search_movies.dart';
import 'package:movie_tmdb/presentation/blocs/movie_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_details/movie_details_event.dart';
import 'package:movie_tmdb/presentation/blocs/movie_event.dart';
import 'package:movie_tmdb/presentation/blocs/popular_people/people_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/popular_people/people_event.dart';
import 'package:movie_tmdb/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/search_bloc/search_event.dart';
import 'package:movie_tmdb/presentation/screens/home_screen.dart';

void main() {
  final movieRepository = MovieRepositoryImpl(); // only created once
  final peopleRepository = PeopleRepositoryImpl();
  final getMovieByIdUseCase = GetMovieByIdUseCase(movieRepository);

  final searchMovie = SearchMovies(movieRepository);
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
            create:
                (context) =>
                    MovieDetailBloc(getMovieByIdUseCase),
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
