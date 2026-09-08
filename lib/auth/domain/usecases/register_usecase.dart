import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;
  const RegisterUseCase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
    required String phone,
    int? avatarIndex,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
      phone: phone,
      avatarIndex: avatarIndex,
    );
  }
}