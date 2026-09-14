import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
  @override
  List<Object?> get props => [];
}

class MoviesRequested extends MoviesEvent {
  const MoviesRequested();
}