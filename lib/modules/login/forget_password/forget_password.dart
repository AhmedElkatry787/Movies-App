import 'package:flutter/material.dart';

import '../../../core/app_colors/app_colors.dart';
import '../../../model/buttom_model.dart';
import '../../../model/textfromfield_model.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Forget Password',
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
            Image.asset(
              'assets/images/Forgotpassword.png',
              width: 380,
              height: 380,
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
            CustomButton(
              text: 'Verify Email',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
