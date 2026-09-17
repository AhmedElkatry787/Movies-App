import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import '../../domain/usecases/get_movie_suggestions_usecase.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetMovieSuggestionsUseCase getMovieSuggestionsUseCase;

  MovieDetailsBloc({
    required this.getMovieDetailsUseCase,
    required this.getMovieSuggestionsUseCase,
  }) : super(const MovieDetailsInitial()) {
    on<MovieDetailsRequested>(_onMovieDetailsRequested);
  }

  Future<void> _onMovieDetailsRequested(
      MovieDetailsRequested event,
      Emitter<MovieDetailsState> emit,
      ) async {
    emit(const MovieDetailsLoading());
    try {
      final similarFuture = _loadSimilar(event.movieId);
      final movie = await getMovieDetailsUseCase(event.movieId);
      emit(MovieDetailsLoaded(movie, similarMovies: await similarFuture));
    } on ServerException catch (e) {
      emit(MovieDetailsError(e.message));
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }

  // Similar movies are optional, so a failure here shouldn't hide the details.
  Future<List<MovieEntity>> _loadSimilar(int movieId) async {
    try {
      return await getMovieSuggestionsUseCase(movieId);
    } catch (_) {
      return const [];
    }
  }
}
