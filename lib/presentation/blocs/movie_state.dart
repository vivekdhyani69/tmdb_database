import 'package:equatable/equatable.dart';
import 'package:movie_tmdb/domain/entities/trendingMovie_entity.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<TrendingMovie> movies;
  MovieLoaded(this.movies);
  @override
  List<Object> get props => [movies];
}
