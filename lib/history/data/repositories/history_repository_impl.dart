import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/error/exceptions.dart';
import '../../../movies/data/models/movie_model.dart';
import '../../../movies/domain/entities/movie_entity.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_remote_data_source.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;
  const HistoryRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<MovieEntity>> watchHistory() => remoteDataSource.watchHistory();

  @override
  Future<void> recordView(MovieEntity movie) async {
    try {
      await remoteDataSource.recordView(MovieModel.fromEntity(movie));
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'حدث خطأ غير متوقع، حاول تاني');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
