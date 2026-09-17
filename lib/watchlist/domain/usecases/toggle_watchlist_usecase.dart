import '../../../movies/domain/entities/movie_entity.dart';
import '../repositories/watchlist_repository.dart';

class ToggleWatchlistUseCase {
  final WatchlistRepository repository;
  const ToggleWatchlistUseCase(this.repository);

  Future<void> call(MovieEntity movie, {required bool isSaved}) {
    return isSaved ? repository.removeMovie(movie.id) : repository.addMovie(movie);
  }
}
