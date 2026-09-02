import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_app/core/routes/app_routes.dart';
import 'package:movies_app/core/routes/app_routes_name.dart';

import '../../core/app_colors/app_colors.dart';
import '../home/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
          () {
        Navigator.pushReplacementNamed(
          context,
          AppRoutesName.home,
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(
        child: Image.asset(
          'assets/images/splashimg.png',
        ),
      ),
    );
  }
}
