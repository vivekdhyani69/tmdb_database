import 'package:flutter/material.dart';
import 'package:movie_tmdb/core/routes/route_names.dart';
import 'package:movie_tmdb/presentation/screens/home_screen.dart';
import 'package:movie_tmdb/presentation/screens/people_screen.dart';
import 'package:movie_tmdb/presentation/widgets/movie_trailer_screen.dart';
import 'package:movie_tmdb/presentation/screens/result_page_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //if in setting.name has this and this is same as any case then executes that case

      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomePage());

      case RouteNames.people:
        return MaterialPageRoute(builder: (_) => PeopleScreen());

      case RouteNames.trailer:
        final args = settings.arguments as Map<String, dynamic>?;
        final idString = args?['id'];

        final id = int.tryParse(idString.toString());

        return MaterialPageRoute(builder: (_) => MovieTrailerScreen(id: id));

      case RouteNames.searchedMovie:
        final args = settings.arguments as Map<String, dynamic>?;
        final idString = args?['id'];

        final movieId = int.tryParse(idString?.toString() ?? '');

        if (movieId == null) {
          return MaterialPageRoute(
            builder:
                (_) => Scaffold(body: Center(child: Text('Invalid movie ID'))),
          );
        }

        return MaterialPageRoute(
          builder: (_) => ResultPageScreen(movieId: movieId),
        );

      // case RouteNames.tvToprated:
      // return MaterialPageRoute(builder: (_) => TvTopRated());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
