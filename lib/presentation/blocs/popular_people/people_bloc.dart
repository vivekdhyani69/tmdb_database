import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/domain/repositories/people_repository.dart';
import 'package:movie_tmdb/presentation/blocs/popular_people/people_event.dart';
import 'package:movie_tmdb/presentation/blocs/popular_people/people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final PeopleRepository peopleRepository;
  PeopleBloc(this.peopleRepository) : super(PeopleInitial()) {
    on<FetchPeople>((event, emit) async {
      emit(PeopleLoading()); //Initially the loading state is presents
      try {
        final people = await peopleRepository.getPopularPersons(
          page: event.page,
        );
        emit(PeopleLoaded(people, event.page));
      } catch (e) {
        emit(PeopleError(e.toString()));
      }
    });
  }
}
