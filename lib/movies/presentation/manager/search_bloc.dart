import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/usecases/search_movies_usecase.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMoviesUseCase searchMoviesUseCase;

  /// Kept so a slow request for an older query cannot overwrite a newer one.
  String _latestQuery = '';

  SearchBloc({required this.searchMoviesUseCase}) : super(const SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SearchCleared>(_onSearchCleared);
  }

  Future<void> _onSearchQueryChanged(
      SearchQueryChanged event,
      Emitter<SearchState> emit,
      ) async {
    final query = event.query.trim();
    _latestQuery = query;

    if (query.isEmpty) {
      emit(const SearchInitial());
      return;
    }

    emit(const SearchLoading());
    try {
      final movies = await searchMoviesUseCase(query);
      if (_latestQuery != query) return;
      emit(SearchLoaded(movies, query));
    } on ServerException catch (e) {
      if (_latestQuery != query) return;
      emit(SearchError(e.message));
    } catch (e) {
      if (_latestQuery != query) return;
      emit(SearchError(e.toString()));
    }
  }

  void _onSearchCleared(SearchCleared event, Emitter<SearchState> emit) {
    _latestQuery = '';
    emit(const SearchInitial());
  }
}
