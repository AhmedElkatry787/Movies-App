import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/datasources/watchlist_remote_data_source.dart';
import '../../data/repositories/watchlist_repository_impl.dart';
import '../../domain/usecases/toggle_watchlist_usecase.dart';
import '../../domain/usecases/watch_watchlist_usecase.dart';
import 'watchlist_bloc.dart';

WatchlistBloc buildWatchlistBloc() {
  final dataSource = WatchlistRemoteDataSourceImpl(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
  final repository = WatchlistRepositoryImpl(dataSource);

  return WatchlistBloc(
    watchWatchlistUseCase: WatchWatchlistUseCase(repository),
    toggleWatchlistUseCase: ToggleWatchlistUseCase(repository),
  );
}
