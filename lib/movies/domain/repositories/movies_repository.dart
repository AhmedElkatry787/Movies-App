import '../entities/movie_entity.dart';
import '../entities/movie_details_entity.dart';

abstract class MoviesRepository {
  Future<List<MovieEntity>> getMovies();
  Future<List<MovieEntity>> searchMovies(String query);
  Future<MovieDetailsEntity> getMovieDetails(int movieId);
  Future<List<MovieEntity>> getMovieSuggestions(int movieId);
}