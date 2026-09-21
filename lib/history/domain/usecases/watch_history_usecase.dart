import '../../../movies/domain/entities/movie_entity.dart';
import '../repositories/history_repository.dart';

class WatchHistoryUseCase {
  final HistoryRepository repository;
  const WatchHistoryUseCase(this.repository);

  Stream<List<MovieEntity>> call() => repository.watchHistory();
}
