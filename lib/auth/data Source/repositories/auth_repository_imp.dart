import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../../core/error/exceptions.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      return await remoteDataSource.login(email: email, password: password);
    } on fb.FirebaseAuthException catch (e) {
      throw ServerException(_mapAuthError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    int? avatarIndex,
  }) async {
    try {
      return await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        avatarIndex: avatarIndex,
      );
    } on fb.FirebaseAuthException catch (e) {
      throw ServerException(_mapAuthError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      return await remoteDataSource.signInWithGoogle();
    } on fb.FirebaseAuthException catch (e) {
      throw ServerException(_mapAuthError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> forgetPassword({required String email}) async {
    try {
      await remoteDataSource.forgetPassword(email: email);
    } on fb.FirebaseAuthException catch (e) {
      throw ServerException(_mapAuthError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  @override
  Future<UserEntity> updateProfile({
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    try {
      return await remoteDataSource.updateProfile(
        name: name,
        phone: phone,
        avatarIndex: avatarIndex,
      );
    } on fb.FirebaseAuthException catch (e) {
      throw ServerException(_mapAuthError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();
    } on fb.FirebaseAuthException catch (e) {
      throw ServerException(_mapAuthError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  @override
  Future<UserEntity> getCurrentUser() async {
    try {
      return await remoteDataSource.getCurrentUser();
    } on fb.FirebaseAuthException catch (e) {
      throw ServerException(_mapAuthError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }



  String _mapAuthError(fb.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'لا يوجد حساب بهذا الإيميل';
      case 'wrong-password':
      case 'invalid-credential':
        return 'كلمة المرور غير صحيحة';
      case 'email-already-in-use':
        return 'هذا الإيميل مستخدم بالفعل';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جدًا (لازم 6 حروف على الأقل)';
      case 'invalid-email':
        return 'صيغة الإيميل غير صحيحة';
      case 'requires-recent-login':
        return 'لأمان حسابك، سجّل دخول تاني قبل تنفيذ العملية دي';
      case 'no-current-user':
        return 'لا يوجد مستخدم مسجل دخول حاليًا';
      case 'sign_in_cancelled':
        return e.message ?? 'تم إلغاء العملية';
      default:
        return e.message ?? 'حدث خطأ غير متوقع';

    }
  }
}