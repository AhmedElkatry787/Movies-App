import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_app/core/cache/app_prefs.dart';
import 'package:movies_app/core/routes/app_routes_name.dart';

import '../../core/app_colors/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), _goToNextScreen);
  }

  /// Onboarding is only shown on the first launch; afterwards the splash
  /// goes straight to home.
  Future<void> _goToNextScreen() async {
    final seenOnBoarding = await AppPrefs.isOnBoardingSeen();
    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      seenOnBoarding ? AppRoutesName.home : AppRoutesName.onBoarding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(
        child: Image.asset('assets/images/splashimg.png'),
      ),
    );
  }
}
