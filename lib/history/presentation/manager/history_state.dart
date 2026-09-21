import 'package:equatable/equatable.dart';
import '../../../movies/domain/entities/movie_entity.dart';

class HistoryState extends Equatable {
  final List<MovieEntity> movies;
  final bool isLoading;
  final String? errorMessage;

  const HistoryState({
    this.movies = const [],
    this.isLoading = true,
    this.errorMessage,
  });

  int get count => movies.length;

  HistoryState copyWith({
    List<MovieEntity>? movies,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HistoryState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [movies.map((movie) => movie.id).toList(), isLoading, errorMessage];
}
