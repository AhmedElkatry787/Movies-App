import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/core/routes/app_routes.dart';
import 'package:movies_app/core/routes/app_routes_name.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  await _clearPreviousSession();
  runApp(const MyApp());
}


Future<void> _clearPreviousSession() async {
  try {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  } catch (_) {
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'Inter',
      ),

      initialRoute: AppRoutesName.splash,

      routes: AppRoutes.routes,
    );
  }
}
