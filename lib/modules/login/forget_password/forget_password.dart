import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/manager/auth_bloc.dart';
import '../../../auth/presentation/manager/auth_event.dart';
import '../../../auth/presentation/manager/auth_state.dart';
import '../../../auth/presentation/manager/injection.dart';
import '../../../core/app_colors/app_colors.dart';
import '../../../model/buttom_model.dart';
import '../../../model/textfromfield_model.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => buildAuthBloc(),
      child: const _ForgetPasswordView(),
    );
  }
}

class _ForgetPasswordView extends StatefulWidget {
  const _ForgetPasswordView();

  @override
  State<_ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<_ForgetPasswordView> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is PasswordResetEmailSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إرسال رابط إعادة تعيين كلمة المرور لإيميلك')),
          );
          Navigator.pop(context);
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
          title: const Text('Forget Password', style: TextStyle(color: AppColors.yellow, fontSize: 16)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Image.asset('assets/images/Forgotpassword.png', width: 380, height: 380),
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
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator(color: AppColors.yellow);
                  }
                  return CustomButton(
                    text: 'Verify Email',
                    onPressed: () {
                      if (_emailController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('من فضلك اكتب الإيميل')));
                        return;
                      }
                      context
                          .read<AuthBloc>()
                          .add(ForgetPasswordRequested(email: _emailController.text.trim()));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}