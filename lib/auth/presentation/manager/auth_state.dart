import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final UserEntity user;
  const AuthSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class PasswordResetEmailSent extends AuthState {
  const PasswordResetEmailSent();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

class ProfileUpdated extends AuthState {
  final UserEntity user;
  const ProfileUpdated(this.user);
  @override
  List<Object?> get props => [user];
}

class ProfileUnchanged extends AuthState {
  const ProfileUnchanged();
}

class AccountDeleted extends AuthState {
  const AccountDeleted();
}

class LoggedOut extends AuthState {
  const LoggedOut();
}