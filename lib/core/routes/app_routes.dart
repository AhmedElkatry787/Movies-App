import 'package:flutter/material.dart';
import 'package:movies_app/modules/login/login/login_screen.dart';
import 'package:movies_app/modules/onBoarding/onboarding_screen.dart';
import 'package:movies_app/modules/splash/splash_view.dart';
import '../../modules/home/home_view.dart';
import '../../modules/login/register/register_screen.dart';
import 'app_routes_name.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    AppRoutesName.splash: (_) => const SplashView(),
    AppRoutesName.onBoarding: (_) => const OnBoardingScreen(),
    AppRoutesName.login : (_) => const LoginScreen(),
    AppRoutesName.register : (_) => const RegisterScreen(),
    AppRoutesName.home: (_) => const HomeView(),
  };
}