import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/routes/app_routes_name.dart';
import '../../../auth/presentation/manager/auth_bloc.dart';
import '../../../auth/presentation/manager/auth_state.dart';
import '../../../auth/presentation/manager/injection.dart';
import '../../../core/app_colors/app_colors.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/buttom_model.dart';
import '../../../core/widgets/lang_selector.dart';
import '../../../auth/presentation/manager/auth_event.dart';
import '../../../core/widgets/textfromfield_model.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => buildAuthBloc(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context, AppRoutesName.home, (route) => false,
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SafeArea(
          // Scrolls so short screens and the open keyboard don't overflow it.
          child: SingleChildScrollView(
            padding: context.contentPadding(horizontal: 20, vertical: 20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/splashimg.png', width: context.scaled(200), height: context.scaled(200)),
                  const SizedBox(height: 70),
                  CustomTextFormField(
                    controller: _emailController,
                    prefixIcon: Icons.email,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    fillColor: AppColors.darkGrey,
                    textColor: AppColors.white,
                    hintColor: AppColors.white,
                    height: 56,
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    controller: _passwordController,
                    prefixIcon: Icons.lock,
                    hintText: 'Password',
                    obscureText: true,
                    fillColor: AppColors.darkGrey,
                    textColor: AppColors.white,
                    hintColor: AppColors.white,
                    height: 56,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, AppRoutesName.forgetPassword),
                        child: const Text('Forgot Password?',
                            style: TextStyle(color: AppColors.yellow, fontSize: 16)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 70),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator(color: AppColors.yellow);
                      }
                      return CustomButton(
                        text: 'Login',
                        borderRadius: 15,
                        onPressed: () {
                          context.read<AuthBloc>().add(LoginRequested(
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                          ));
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",
                          style: TextStyle(color: AppColors.white, fontSize: 14)),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, AppRoutesName.register),
                        child: const Text('Sign Up',
                            style: TextStyle(color: AppColors.yellow, fontSize: 14)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text('-------OR-------', style: TextStyle(color: AppColors.yellow, fontSize: 15)),
                  const SizedBox(height: 25),
                  CustomButton(
                    svgIcon: 'assets/icons/google.svg',
                    text: 'Continue with Google',
                    onPressed: () {
                      context.read<AuthBloc>().add(const GoogleSignInRequested());
                    },
                  ),
                  const SizedBox(height: 25),
                  const LanguageSelector(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}