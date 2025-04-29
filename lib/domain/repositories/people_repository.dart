import 'package:movie_tmdb/domain/entities/popularPerson_entity.dart';

abstract class PeopleRepository {
  Future<List<PopularpersonEntity>> getPopularPersons({int page = 1});
}
