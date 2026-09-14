import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class UpdateProfileUseCase {
  final AuthRepository repository;
  const UpdateProfileUseCase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String phone,
    required int avatarIndex,
  }) {
    return repository.updateProfile(
      name: name,
      phone: phone,
      avatarIndex: avatarIndex,
    );
  }
}
