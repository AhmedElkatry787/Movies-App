import '../../data/datasources/movies_remote_data_source.dart';
import '../../data/repositories/movies_repository_impl.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import 'movies_bloc.dart';
import 'movie_details_bloc.dart';

MoviesBloc buildMoviesBloc() {
  final dataSource = MoviesRemoteDataSourceImpl();
  final repository = MoviesRepositoryImpl(dataSource);

  return MoviesBloc(
    getMoviesUseCase: GetMoviesUseCase(repository),
  );
}

MovieDetailsBloc buildMovieDetailsBloc() {
  final dataSource = MoviesRemoteDataSourceImpl();
  final repository = MoviesRepositoryImpl(dataSource);

  return MovieDetailsBloc(
    getMovieDetailsUseCase: GetMovieDetailsUseCase(repository),
  );
}