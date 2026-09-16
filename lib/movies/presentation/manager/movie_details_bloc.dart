import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;

  MovieDetailsBloc({required this.getMovieDetailsUseCase})
      : super(const MovieDetailsInitial()) {
    on<MovieDetailsRequested>(_onMovieDetailsRequested);
  }

  Future<void> _onMovieDetailsRequested(
      MovieDetailsRequested event,
      Emitter<MovieDetailsState> emit,
      ) async {
    emit(const MovieDetailsLoading());
    try {
      final movie = await getMovieDetailsUseCase(event.movieId);
      emit(MovieDetailsLoaded(movie));
    } on ServerException catch (e) {
      emit(MovieDetailsError(e.message));
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }
}