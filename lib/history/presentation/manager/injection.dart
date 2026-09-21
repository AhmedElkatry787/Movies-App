import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/datasources/history_remote_data_source.dart';
import '../../data/repositories/history_repository_impl.dart';
import '../../domain/usecases/record_history_usecase.dart';
import '../../domain/usecases/watch_history_usecase.dart';
import 'history_bloc.dart';

HistoryBloc buildHistoryBloc() {
  final dataSource = HistoryRemoteDataSourceImpl(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
  final repository = HistoryRepositoryImpl(dataSource);

  return HistoryBloc(
    watchHistoryUseCase: WatchHistoryUseCase(repository),
    recordHistoryUseCase: RecordHistoryUseCase(repository),
  );
}
