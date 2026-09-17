import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/usecases/toggle_watchlist_usecase.dart';
import '../../domain/usecases/watch_watchlist_usecase.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchWatchlistUseCase watchWatchlistUseCase;
  final ToggleWatchlistUseCase toggleWatchlistUseCase;

  WatchlistBloc({
    required this.watchWatchlistUseCase,
    required this.toggleWatchlistUseCase,
  }) : super(const WatchlistState()) {
    on<WatchlistSubscriptionRequested>(_onSubscriptionRequested);
    on<WatchlistToggled>(_onToggled);
  }

  Future<void> _onSubscriptionRequested(
      WatchlistSubscriptionRequested event,
      Emitter<WatchlistState> emit,
      ) {
    return emit.forEach(
      watchWatchlistUseCase(),
      onData: (movies) => state.copyWith(movies: movies, isLoading: false),
      onError: (error, _) => state.copyWith(isLoading: false, errorMessage: error.toString()),
    );
  }

  Future<void> _onToggled(
      WatchlistToggled event,
      Emitter<WatchlistState> emit,
      ) async {
    try {
      await toggleWatchlistUseCase(event.movie, isSaved: state.contains(event.movie.id));
    } on ServerException catch (e) {
      emit(state.copyWith(errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
