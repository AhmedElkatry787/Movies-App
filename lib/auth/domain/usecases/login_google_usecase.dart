import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GoogleSignInUseCase {
  final AuthRepository repository;
  const GoogleSignInUseCase(this.repository);

  Future<UserEntity> call() => repository.signInWithGoogle();
}