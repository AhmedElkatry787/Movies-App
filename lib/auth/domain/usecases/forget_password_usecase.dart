import '../repositories/auth_repository.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;
  const ForgetPasswordUseCase(this.repository);

  Future<void> call({required String email}) {
    return repository.forgetPassword(email: email);
  }
}