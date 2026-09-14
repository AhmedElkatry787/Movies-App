import '../entities/movie_entity.dart';
import '../repositories/movies_repository.dart';

class GetMoviesUseCase {
  final MoviesRepository repository;
  const GetMoviesUseCase(this.repository);

  Future<List<MovieEntity>> call() => repository.getMovies();
}