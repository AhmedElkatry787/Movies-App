import 'package:flutter/material.dart';
import 'package:movies_app/modules/splash/splash_view.dart';
import 'package:movies_app/core/routes/app_routes.dart';
import 'package:movies_app/core/routes/app_routes_name.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutesName.splash,

      routes: AppRoutes.routes,
    );
  }
}

