import 'package:flutter/material.dart';
import 'package:movies_app/modules/login/register/widgets/avatar_selector.dart';

import '../../../core/app_colors/app_colors.dart';

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
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          AvatarSelector(onAvatarSelected: (index) {})
        ],
      ),
    );
  }
}
