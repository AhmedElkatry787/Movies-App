import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  const AppPrefs._();

  static const String _onBoardingSeenKey = 'onboarding_seen';

  static Future<bool> isOnBoardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onBoardingSeenKey) ?? false;
  }

  static Future<void> setOnBoardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onBoardingSeenKey, true);
  }
}
