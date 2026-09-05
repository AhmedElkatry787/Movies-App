import 'package:flutter/material.dart';
import 'package:movies_app/core/routes/app_routes_name.dart';

import '../../../core/app_colors/app_colors.dart';
import '../../../model/buttom_model.dart';
import '../../../model/textfromfield_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/splashimg.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 70),
                CustomTextFormField(
                  prefixIcon: Icons.email,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  fillColor: AppColors.darkGrey,
                  textColor: AppColors.white,
                  hintColor: AppColors.white,
                  height: 56,
                ),
                SizedBox(height: 30),
                CustomTextFormField(
                  prefixIcon: Icons.lock,
                  hintText: 'Password',
                  obscureText: true,
                  fillColor: AppColors.darkGrey,
                  textColor: AppColors.white,
                  hintColor: AppColors.white,
                  height: 56,
                  suffixIcon: Icon(Icons.visibility_off, color: AppColors.white, size: 30,),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.yellow,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 70),
                CustomButton(
                  onPressed: () {  },
                  text: 'Login',
                  borderRadius: 15,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutesName.register);
                      },
                      child: Text(
                        'Sign Up',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.yellow,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '-------OR-------',
                      style: TextStyle(
                          color: AppColors.yellow,
                          fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                CustomButton(
                  svgIcon: 'assets/icons/google.svg',
                    text: 'Continue with Google',
                    onPressed: (){},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
