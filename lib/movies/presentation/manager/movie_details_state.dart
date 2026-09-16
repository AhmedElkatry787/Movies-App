import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_details_entity.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();
  @override
  List<Object?> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {
  const MovieDetailsInitial();
}

class MovieDetailsLoading extends MovieDetailsState {
  const MovieDetailsLoading();
}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetailsEntity movie;
  const MovieDetailsLoaded(this.movie);

  @override
  List<Object?> get props => [movie];
}

class MovieDetailsError extends MovieDetailsState {
  final String message;
  const MovieDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}