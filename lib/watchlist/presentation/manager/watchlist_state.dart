import 'package:equatable/equatable.dart';
import '../../../movies/domain/entities/movie_entity.dart';

class WatchlistState extends Equatable {
  final List<MovieEntity> movies;
  final bool isLoading;
  final String? errorMessage;

  const WatchlistState({
    this.movies = const [],
    this.isLoading = true,
    this.errorMessage,
  });

  int get count => movies.length;

  bool contains(int movieId) => movies.any((movie) => movie.id == movieId);

  WatchlistState copyWith({
    List<MovieEntity>? movies,
    bool? isLoading,
    String? errorMessage,
  }) {
    return WatchlistState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [movies.map((movie) => movie.id).toList(), isLoading, errorMessage];
}
