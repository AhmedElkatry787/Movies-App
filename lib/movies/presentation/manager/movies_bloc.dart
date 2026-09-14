import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import 'movies_event.dart';
import 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesUseCase getMoviesUseCase;

  MoviesBloc({required this.getMoviesUseCase}) : super(const MoviesInitial()) {
    on<MoviesRequested>(_onMoviesRequested);
  }

  Future<void> _onMoviesRequested(
      MoviesRequested event,
      Emitter<MoviesState> emit,
      ) async {
    emit(const MoviesLoading());
    try {
      final movies = await getMoviesUseCase();
      emit(MoviesLoaded(movies));
    } on ServerException catch (e) {
      emit(MoviesError(e.message));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }
}