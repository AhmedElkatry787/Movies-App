import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/error/exceptions.dart';
import '../../../movies/data/models/movie_model.dart';

abstract class WatchlistRemoteDataSource {
  Stream<List<MovieModel>> watchWatchlist();
  Future<void> addMovie(MovieModel movie);
  Future<void> removeMovie(int movieId);
}

class WatchlistRemoteDataSourceImpl implements WatchlistRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  WatchlistRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  CollectionReference<Map<String, dynamic>> _collection() {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) throw const ServerException('Please log in first');
    return firestore.collection('users').doc(uid).collection('watchlist');
  }

  @override
  Stream<List<MovieModel>> watchWatchlist() {
    if (firebaseAuth.currentUser == null) return Stream.value(const []);

    return _collection()
        .orderBy('added_at', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => MovieModel.fromJson(doc.data())).toList());
  }

  @override
  Future<void> addMovie(MovieModel movie) {
    return _collection().doc('${movie.id}').set({
      ...movie.toMap(),
      'added_at': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> removeMovie(int movieId) {
    return _collection().doc('$movieId').delete();
  }
}
