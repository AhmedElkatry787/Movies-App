import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/error/exceptions.dart';
import '../../../movies/data/models/movie_model.dart';
import '../../../movies/domain/entities/movie_entity.dart';
import '../../domain/repositories/watchlist_repository.dart';
import '../datasources/watchlist_remote_data_source.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistRemoteDataSource remoteDataSource;
  const WatchlistRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<MovieEntity>> watchWatchlist() => remoteDataSource.watchWatchlist();

  @override
  Future<void> addMovie(MovieEntity movie) {
    return _guard(() => remoteDataSource.addMovie(MovieModel.fromEntity(movie)));
  }

  @override
  Future<void> removeMovie(int movieId) {
    return _guard(() => remoteDataSource.removeMovie(movieId));
  }

  Future<void> _guard(Future<void> Function() action) async {
    try {
      await action();
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'حدث خطأ غير متوقع، حاول تاني');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
