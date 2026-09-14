import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    _start();
  }

  Future<void> _start() async {
    final sessionFuture = _restoreSession();
    await Future<void>.delayed(const Duration(seconds: 3));
    final user = await sessionFuture;

    if (!mounted) return;

    if (user != null) {
      Navigator.pushReplacementNamed(context, AppRoutesName.home);
      return;
    }

    final seenOnBoarding = await AppPrefs.isOnBoardingSeen();
    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      seenOnBoarding ? AppRoutesName.login : AppRoutesName.onBoarding,
    );
  }

  Future<User?> _restoreSession() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) return user;
    try {
      return await FirebaseAuth.instance
          .authStateChanges()
          .first
          .timeout(const Duration(seconds: 5));
    } catch (_) {
      return FirebaseAuth.instance.currentUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(child: Image.asset('assets/images/splashimg.png')),
    );
  }
}
