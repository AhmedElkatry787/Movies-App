import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/usecases/record_history_usecase.dart';
import '../../domain/usecases/watch_history_usecase.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final WatchHistoryUseCase watchHistoryUseCase;
  final RecordHistoryUseCase recordHistoryUseCase;

  HistoryBloc({
    required this.watchHistoryUseCase,
    required this.recordHistoryUseCase,
  }) : super(const HistoryState()) {
    on<HistorySubscriptionRequested>(_onSubscriptionRequested);
    on<HistoryRecorded>(_onRecorded);
  }

  Future<void> _onSubscriptionRequested(
      HistorySubscriptionRequested event,
      Emitter<HistoryState> emit,
      ) {
    return emit.forEach(
      watchHistoryUseCase(),
      onData: (movies) => state.copyWith(movies: movies, isLoading: false),
      onError: (error, _) => state.copyWith(isLoading: false, errorMessage: error.toString()),
    );
  }

  Future<void> _onRecorded(
      HistoryRecorded event,
      Emitter<HistoryState> emit,
      ) async {
    try {
      await recordHistoryUseCase(event.movie);
    } on ServerException catch (e) {
      emit(state.copyWith(errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
