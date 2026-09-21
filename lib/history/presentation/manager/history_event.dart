import 'package:equatable/equatable.dart';
import '../../../movies/domain/entities/movie_entity.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
  @override
  List<Object?> get props => [];
}

class HistorySubscriptionRequested extends HistoryEvent {
  const HistorySubscriptionRequested();
}

class HistoryRecorded extends HistoryEvent {
  final MovieEntity movie;
  const HistoryRecorded(this.movie);

  @override
  List<Object?> get props => [movie.id];
}
