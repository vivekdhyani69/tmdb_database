import 'package:equatable/equatable.dart';

abstract class PeopleEvent {}

class FetchPeople extends PeopleEvent {
  final int page;

  FetchPeople(this.page);
}
