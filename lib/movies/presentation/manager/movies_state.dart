import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_entity.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();
  @override
  List<Object?> get props => [];
}

class MoviesInitial extends MoviesState {
  const MoviesInitial();
}

class MoviesLoading extends MoviesState {
  const MoviesLoading();
}

class MoviesLoaded extends MoviesState {
  final List<MovieEntity> movies;
  const MoviesLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}

class MoviesError extends MoviesState {
  final String message;
  const MoviesError(this.message);
  @override
  List<Object?> get props => [message];
}