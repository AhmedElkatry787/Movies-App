import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/error/exceptions.dart';
import '../../../movies/data/models/movie_model.dart';

abstract class HistoryRemoteDataSource {
  Stream<List<MovieModel>> watchHistory();
  Future<void> recordView(MovieModel movie);
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  /// Only the last [historyLimit] watched movies are kept.
  static const int historyLimit = 20;

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  HistoryRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  CollectionReference<Map<String, dynamic>> _collection() {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) throw const ServerException('Please log in first');
    return firestore.collection('users').doc(uid).collection('history');
  }

  @override
  Stream<List<MovieModel>> watchHistory() {
    if (firebaseAuth.currentUser == null) return Stream.value(const []);

    return _collection()
        .orderBy('viewed_at', descending: true)
        .limit(historyLimit)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => MovieModel.fromJson(doc.data())).toList());
  }

  @override
  Future<void> recordView(MovieModel movie) async {
    final docId = '${movie.id}';

    // Re-watching a movie moves it back to the top instead of adding a duplicate.
    await _collection().doc(docId).set({
      ...movie.toMap(),
      'viewed_at': FieldValue.serverTimestamp(),
    });

    await _pruneOlderThanLimit(keptDocId: docId);
  }

  /// The movie just written is kept aside rather than ordered with the rest: its
  /// server timestamp is still null locally, so it would sort to the wrong end.
  Future<void> _pruneOlderThanLimit({required String keptDocId}) async {
    final snapshot = await _collection().orderBy('viewed_at', descending: true).get();

    final stale = snapshot.docs
        .where((doc) => doc.id != keptDocId)
        .skip(historyLimit - 1)
        .toList();
    if (stale.isEmpty) return;

    final batch = firestore.batch();
    for (final doc in stale) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
