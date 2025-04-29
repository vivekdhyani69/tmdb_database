import 'dart:convert';

import 'package:movie_tmdb/core/constants/api_constants.dart';
import 'package:movie_tmdb/data/models/movie_model.dart';
import 'package:movie_tmdb/data/models/searchList_model.dart';
import 'package:movie_tmdb/data/models/trailer_models.dart';
import 'package:movie_tmdb/data/models/trending_movie.dart';
import 'package:movie_tmdb/domain/entities/movie_entity.dart';
import 'package:movie_tmdb/domain/entities/search_entity.dart';

import 'package:movie_tmdb/domain/entities/trailerModel_entity.dart';
import 'package:movie_tmdb/domain/entities/trendingMovie_entity.dart';
import 'package:movie_tmdb/domain/repositories/movie_repository.dart';
import 'package:http/http.dart' as http;
import 'package:movie_tmdb/domain/usecases/get_movie_by_id_usecase.dart';

class MovieRepositoryImpl implements MovieRepository {
  @override
  ///gets all movies
  Future<List<TrendingMovie>> getTrendingMovies() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/trending/movie/day?language=en-US'),
      headers: {
        'Authorization': 'Bearer ${ApiConstants.token}',
        'Accept': 'application/json',
      },
    );
    // print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['results'];
      return movies.map((movie) => TrendingMovieModel.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  ///get movie trailers
  Future<List<TrailerModel>> getTrailersMovies(int movieId) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}/movie/$movieId/videos?language=en-US',
    );
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${ApiConstants.token}',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(
        response.body,
      ); //After decodes we have json part
      final List trailersJson = jsonData['results']; //now extract result array
      ///now converts into dart model
      return trailersJson.map((e) => TrailerMovieModels.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load trailers');
    }
  }

  Future<List<SearchEntity>> getSearchMovies(String query) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/search/movie?query=$query');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${ApiConstants.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List searchResult = jsonData['results'];
      if (searchResult == null) {
        throw Exception('No results found');
      }
      return searchResult
          .map((results) => SearchlistModel.fromJson(results))
          .toList();
    } else {
      throw Exception('Failed to load More');
    }
  }

Future<MovieEntity> getMovieById(int id) async{

  final url = Uri.parse('${ApiConstants.baseUrl}/movie/$id?language=en-US');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer ${ApiConstants.token}',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    return MovieModel.fromJson(jsonData);
  } else {
    throw Exception('Failed to load More');
  }
}


}
