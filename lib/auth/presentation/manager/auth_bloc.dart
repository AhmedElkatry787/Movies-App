import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/usecases/login_google_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/forget_password_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GoogleSignInUseCase googleSignInUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final LogoutUseCase logoutUseCase;


  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.googleSignInUseCase,
    required this.getCurrentUserUseCase,
    required this.forgetPasswordUseCase,
    required this.logoutUseCase,
  }) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<ForgetPasswordRequested>(_onForgetPasswordRequested);
    on<CurrentUserRequested>(_onCurrentUserRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final user = await loginUseCase(email: event.email, password: event.password);
      emit(AuthSuccess(user));
    } on ServerException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final user = await registerUseCase(
        name: event.name,
        email: event.email,
        password: event.password,
        phone: event.phone,
        avatarIndex: event.avatarIndex,
      );
      emit(AuthSuccess(user));
    } on ServerException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onGoogleSignInRequested(GoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final user = await googleSignInUseCase();
      emit(AuthSuccess(user));
    } on ServerException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onForgetPasswordRequested(ForgetPasswordRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await forgetPasswordUseCase(email: event.email);
      emit(const PasswordResetEmailSent());
    } on ServerException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    try {
      await logoutUseCase();
      emit(const LoggedOut());
    } on ServerException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onCurrentUserRequested(
      CurrentUserRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(const AuthLoading());
    try {
      final user = await getCurrentUserUseCase();
      emit(AuthSuccess(user));
    } on ServerException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}