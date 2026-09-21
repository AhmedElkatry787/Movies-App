import '../entities/movie_entity.dart';
import '../repositories/movies_repository.dart';

class SearchMoviesUseCase {
  final MoviesRepository repository;
  const SearchMoviesUseCase(this.repository);

  Future<List<MovieEntity>> call(String query) => repository.searchMovies(query);
}
