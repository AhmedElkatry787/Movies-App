import '../../../movies/domain/entities/movie_entity.dart';

abstract class WatchlistRepository {
  Stream<List<MovieEntity>> watchWatchlist();
  Future<void> addMovie(MovieEntity movie);
  Future<void> removeMovie(int movieId);
}
