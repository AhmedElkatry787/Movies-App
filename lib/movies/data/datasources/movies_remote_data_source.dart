import '../../../core/network/dio_api_client.dart';
import '../../../core/network/end_point.dart';
import '../models/movie_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getMovies();
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  static const int _pageSize = 50;
  static const int _pageCount = 4;

  @override
  Future<List<MovieModel>> getMovies() async {
    final pages = await Future.wait([
      for (var page = 1; page <= _pageCount; page++) _getPage(page),
    ]);

    final byId = <int, MovieModel>{};
    for (final page in pages) {
      for (final movie in page) {
        byId[movie.id] = movie;
      }
    }
    return byId.values.toList();
  }

  Future<List<MovieModel>> _getPage(int page) async {
    final response = await DioApiClient.instance.get(
      EndPoints.listMovies,
      queryParameters: {'limit': _pageSize, 'page': page},
    );

    final moviesJson =
        response.data['data']['movies'] as List<dynamic>? ?? [];

    return moviesJson
        .map((movieJson) => MovieModel.fromJson(movieJson as Map<String, dynamic>))
        .toList();
  }
}
