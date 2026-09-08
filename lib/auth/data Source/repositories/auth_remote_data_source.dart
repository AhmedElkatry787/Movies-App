import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
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
    await user.updateDisplayName(name);

    final model = UserModel(
      id: user.uid,
      name: name,
      email: email,
      phone: phone,
      avatarIndex: avatarIndex,
    );
    await firestore.collection('users').doc(user.uid).set(model.toMap());
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

    final doc = await firestore.collection('users').doc(user.uid).get();
    if (doc.exists) return UserModel.fromMap(doc.data()!);

    final model = UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );
    await firestore.collection('users').doc(user.uid).set(model.toMap());
    return model;
  }

  @override
  Future<void> forgetPassword({required String email}) {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<UserModel> _fetchProfile(fb.User user) async {
    final doc = await firestore.collection('users').doc(user.uid).get();
    if (doc.exists) return UserModel.fromMap(doc.data()!);
    return UserModel(id: user.uid, name: user.displayName ?? '', email: user.email ?? '');
  }
}