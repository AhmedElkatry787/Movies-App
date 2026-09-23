import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/modules/login/register/widgets/avatar_selector.dart';
import '../../../auth/presentation/manager/auth_bloc.dart';
import '../../../auth/presentation/manager/auth_event.dart';
import '../../../auth/presentation/manager/auth_state.dart';
import '../../../auth/presentation/manager/injection.dart';
import '../../../core/app_colors/app_colors.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/routes/app_routes_name.dart';
import '../../../core/widgets/buttom_model.dart';
import '../../../core/widgets/lang_selector.dart';
import '../../../core/widgets/textfromfield_model.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => buildAuthBloc(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  int _avatarIndex = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        _phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('من فضلك املأ كل الحقول')));
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('كلمة المرور غير متطابقة')));
      return;
    }
    context.read<AuthBloc>().add(RegisterRequested(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      phone: _phoneController.text.trim(),
      avatarIndex: _avatarIndex,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إنشاء الحساب بنجاح، سجّل دخولك الآن')),
          );
          Navigator.pushNamedAndRemoveUntil(
            context, AppRoutesName.login, (route) => false,
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        appBar: AppBar(
          backgroundColor: AppColors.darkBackground,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.yellow),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Register', style: TextStyle(color: AppColors.yellow, fontSize: 16)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: context.contentPadding(horizontal: 18, vertical: 18),
          child: Column(
            children: [
              AvatarSelector(onAvatarSelected: (index) => setState(() => _avatarIndex = index)),
              const SizedBox(height: 12),
              CustomTextFormField(
                controller: _nameController,
                prefixIcon: Icons.perm_identity_outlined,
                hintText: 'Name',
                keyboardType: TextInputType.text,
                fillColor: AppColors.darkGrey,
                textColor: AppColors.white,
                hintColor: AppColors.white,
                height: 56,
              ),
              const SizedBox(height: 24),
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
              const SizedBox(height: 24),
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
              const SizedBox(height: 24),
              CustomTextFormField(
                controller: _confirmPasswordController,
                prefixIcon: Icons.lock,
                hintText: 'Confirm Password',
                obscureText: true,
                fillColor: AppColors.darkGrey,
                textColor: AppColors.white,
                hintColor: AppColors.white,
                height: 56,
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                controller: _phoneController,
                prefixIcon: Icons.phone,
                hintText: 'Phone Number',
                keyboardType: TextInputType.phone,
                fillColor: AppColors.darkGrey,
                textColor: AppColors.white,
                hintColor: AppColors.white,
                height: 56,
              ),
              const SizedBox(height: 24),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator(color: AppColors.yellow);
                  }
                  return CustomButton(text: 'Create Account', onPressed: () => _submit(context));
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?',
                      style: TextStyle(color: AppColors.white, fontSize: 14)),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text('Login', style: TextStyle(color: AppColors.yellow, fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const LanguageSelector(),
            ],
          ),
        ),
      ),
    );
  }
}