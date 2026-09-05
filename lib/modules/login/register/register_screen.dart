import 'package:flutter/material.dart';
import 'package:movies_app/model/buttom_model.dart';
import 'package:movies_app/model/textfromfield_model.dart';
import 'package:movies_app/modules/login/register/widgets/avatar_selector.dart';
import '../../../core/app_colors/app_colors.dart';
import '../../../model/lang_selector.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.yellow,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Register',
          style: TextStyle(
            color: AppColors.yellow,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            AvatarSelector(onAvatarSelected: (index) {}),
            const SizedBox(height: 12),
            CustomTextFormField(
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
              prefixIcon: Icons.phone,
              hintText: 'Phone Number',
              keyboardType: TextInputType.phone,
              fillColor: AppColors.darkGrey,
              textColor: AppColors.white,
              hintColor: AppColors.white,
              height: 56,
            ),
            const SizedBox(height: 24),
            CustomButton(
                text: 'Create Account',
                onPressed: (){}
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Login',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppColors.yellow,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            LanguageSelector(),
          ],
        ),
      ),
    );
  }
}
