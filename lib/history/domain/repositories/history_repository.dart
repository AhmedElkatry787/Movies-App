import '../../../movies/domain/entities/movie_entity.dart';

abstract class HistoryRepository {
  Stream<List<MovieEntity>> watchHistory();
  Future<void> recordView(MovieEntity movie);
}
