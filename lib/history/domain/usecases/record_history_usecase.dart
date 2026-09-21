import '../../../movies/domain/entities/movie_entity.dart';
import '../repositories/history_repository.dart';

class RecordHistoryUseCase {
  final HistoryRepository repository;
  const RecordHistoryUseCase(this.repository);

  Future<void> call(MovieEntity movie) => repository.recordView(movie);
}
