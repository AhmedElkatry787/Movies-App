import 'package:dio/dio.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/entities/movie_details_entity.dart';
import '../../domain/repositories/movies_repository.dart';
import '../datasources/movies_remote_data_source.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remoteDataSource;
  const MoviesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MovieEntity>> getMovies() async {
    try {
      return await remoteDataSource.getMovies();
    } on DioException catch (e) {
      throw ServerException(_mapDioError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<MovieDetailsEntity> getMovieDetails(int movieId) async {
    try {
      return await remoteDataSource.getMovieDetails(movieId);
    } on DioException catch (e) {
      throw ServerException(_mapDioError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'الاتصال بطيء جدًا، حاول تاني';
      case DioExceptionType.connectionError:
        return 'تأكد من اتصالك بالإنترنت';
      case DioExceptionType.badResponse:
        return 'حصل خطأ من السيرفر (${e.response?.statusCode})';
      default:
        return 'حدث خطأ غير متوقع، حاول تاني';
    }
  }
}