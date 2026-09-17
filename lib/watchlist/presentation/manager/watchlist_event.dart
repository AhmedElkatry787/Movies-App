import 'package:equatable/equatable.dart';
import '../../../movies/domain/entities/movie_entity.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();
  @override
  List<Object?> get props => [];
}

class WatchlistSubscriptionRequested extends WatchlistEvent {
  const WatchlistSubscriptionRequested();
}

class WatchlistToggled extends WatchlistEvent {
  final MovieEntity movie;
  const WatchlistToggled(this.movie);

  @override
  List<Object?> get props => [movie.id];
}
