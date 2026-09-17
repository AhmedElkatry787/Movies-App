import '../entities/movie_entity.dart';
import '../repositories/movies_repository.dart';

class GetMovieSuggestionsUseCase {
  final MoviesRepository repository;
  const GetMovieSuggestionsUseCase(this.repository);

  Future<List<MovieEntity>> call(int movieId) => repository.getMovieSuggestions(movieId);
}
