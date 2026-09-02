import 'package:flutter/material.dart';
import 'package:movies_app/modules/splash/splash_view.dart';

import '../../modules/home/home_view.dart';
import 'app_routes_name.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    AppRoutesName.splash: (_) => const SplashView(),
    AppRoutesName.home: (_) => const HomeView(),
  };
}