import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/auth/data%20Source/repositories/auth_repository_imp.dart';
import '../../data Source/repositories/auth_remote_data_source.dart';
import '../../domain/usecases/forget_password_usecase.dart';
import '../../domain/usecases/login_google_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_bloc.dart';

AuthBloc buildAuthBloc() {
  final dataSource = AuthRemoteDataSourceImpl(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    googleSignIn: GoogleSignIn(),
  );

  final repository = AuthRepositoryImpl(dataSource);

  return AuthBloc(
    loginUseCase: LoginUseCase(repository),
    registerUseCase: RegisterUseCase(repository),
    googleSignInUseCase: GoogleSignInUseCase(repository),
    forgetPasswordUseCase: ForgetPasswordUseCase(repository),
  );
}