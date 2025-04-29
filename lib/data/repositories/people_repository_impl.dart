import 'dart:convert';

import 'package:movie_tmdb/core/constants/api_constants.dart';
import 'package:movie_tmdb/data/models/popularPersons_models.dart';
import 'package:movie_tmdb/domain/entities/popularPerson_entity.dart';
import 'package:movie_tmdb/domain/repositories/people_repository.dart';
import 'package:http/http.dart' as http;

class PeopleRepositoryImpl implements PeopleRepository {
  @override
  Future<List<PopularpersonEntity>> getPopularPersons({int page = 1}) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/person/popular?&page=$page');

    ///dynaic page repsonse for pagination

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${ApiConstants.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List popularPeople = jsonData['results'];

      return popularPeople
          .map((people) => PopularpersonsModels.fromJson(people))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
