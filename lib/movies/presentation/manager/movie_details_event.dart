import 'package:equatable/equatable.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
  @override
  List<Object?> get props => [];
}

class MovieDetailsRequested extends MovieDetailsEvent {
  final int movieId;
  const MovieDetailsRequested(this.movieId);

  @override
  List<Object?> get props => [movieId];
}