import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  const LoginRequested({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String phone;
  final int? avatarIndex;
  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    this.avatarIndex,
  });
  @override
  List<Object?> get props => [name, email, password, phone, avatarIndex];
}

class GoogleSignInRequested extends AuthEvent {
  const GoogleSignInRequested();
}

class ForgetPasswordRequested extends AuthEvent {
  final String email;
  const ForgetPasswordRequested({required this.email});
  @override
  List<Object?> get props => [email];
}

class CurrentUserRequested extends AuthEvent {
  const CurrentUserRequested();
}

class UpdateProfileRequested extends AuthEvent {
  final UserEntity original;
  final String name;
  final String phone;
  final int avatarIndex;
  const UpdateProfileRequested({
    required this.original,
    required this.name,
    required this.phone,
    required this.avatarIndex,
  });

  bool get hasChanges =>
      name != original.name ||
      phone != (original.phone ?? '') ||
      avatarIndex != (original.avatarIndex ?? 0);

  @override
  List<Object?> get props => [original.id, name, phone, avatarIndex];
}

class DeleteAccountRequested extends AuthEvent {
  const DeleteAccountRequested();
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}