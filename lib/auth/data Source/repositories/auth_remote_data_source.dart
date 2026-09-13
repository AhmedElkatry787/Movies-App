import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/entities/user_model.dart';


abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    int? avatarIndex,
  });
  Future<UserModel> signInWithGoogle();
  Future<void> forgetPassword({required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  static const Duration _profileWriteTimeout = Duration(seconds: 10);

  final fb.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.googleSignIn,
  });

  @override
  Future<UserModel> login({required String email, required String password}) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _fetchProfile(credential.user!);
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    int? avatarIndex,
  }) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user!;

    final model = UserModel(
      id: user.uid,
      name: name,
      email: email,
      phone: phone,
      avatarIndex: avatarIndex,
    );

    try {
      await user.updateDisplayName(name).timeout(_profileWriteTimeout);
      await firestore
          .collection('users')
          .doc(user.uid)
          .set(model.toMap())
          .timeout(_profileWriteTimeout);
    } catch (e) {
      debugPrint('register: could not save the user profile -> $e');
    }


    await firebaseAuth.signOut();
    return model;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw fb.FirebaseAuthException(
        code: 'sign_in_cancelled',
        message: 'تم إلغاء تسجيل الدخول بجوجل',
      );
    }
    final googleAuth = await googleUser.authentication;
    final credential = fb.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user!;

    final model = UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );

    try {
      final docRef = firestore.collection('users').doc(user.uid);
      final doc = await docRef.get().timeout(_profileWriteTimeout);
      if (doc.exists) return UserModel.fromMap(doc.data()!);
      await docRef.set(model.toMap()).timeout(_profileWriteTimeout);
    } catch (e) {
      debugPrint('google sign-in: could not sync the user profile -> $e');
    }
    return model;
  }

  @override
  Future<void> forgetPassword({required String email}) {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<UserModel> _fetchProfile(fb.User user) async {
    try {
      final doc = await firestore
          .collection('users')
          .doc(user.uid)
          .get()
          .timeout(_profileWriteTimeout);
      if (doc.exists) return UserModel.fromMap(doc.data()!);
    } catch (e) {
      debugPrint('login: could not read the user profile -> $e');
    }
    return UserModel(id: user.uid, name: user.displayName ?? '', email: user.email ?? '');
  }
}