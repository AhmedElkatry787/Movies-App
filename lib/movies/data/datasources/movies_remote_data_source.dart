import '../../../core/network/dio_api_client.dart';
import '../../../core/network/end_point.dart';
import '../models/movie_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getMovies();
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  @override
  Future<List<MovieModel>> getMovies() async {
    final response = await DioApiClient.instance.get(EndPoints.listMovies);

    final moviesJson =
        response.data['data']['movies'] as List<dynamic>? ?? [];

    return moviesJson
        .map((movieJson) => MovieModel.fromJson(movieJson as Map<String, dynamic>))
        .toList();
  }
}