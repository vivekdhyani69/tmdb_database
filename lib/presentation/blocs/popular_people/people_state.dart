import 'package:movie_tmdb/domain/entities/popularPerson_entity.dart';

abstract class PeopleState {}

class PeopleInitial extends PeopleState {}

class PeopleLoading extends PeopleState {}

class PeopleLoaded extends PeopleState {
  final List<PopularpersonEntity> peopleList;
  final int currentPage;

  PeopleLoaded(this.peopleList, this.currentPage);
}

class PeopleError extends PeopleState {
  final String message;
  PeopleError(this.message);
}
