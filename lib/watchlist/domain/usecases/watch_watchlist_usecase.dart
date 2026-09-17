import '../../../movies/domain/entities/movie_entity.dart';
import '../repositories/watchlist_repository.dart';

class WatchWatchlistUseCase {
  final WatchlistRepository repository;
  const WatchWatchlistUseCase(this.repository);

  Stream<List<MovieEntity>> call() => repository.watchWatchlist();
}
