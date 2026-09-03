import 'package:shared_preferences/shared_preferences.dart';

/// Small wrapper around the values the app persists between launches.
class AppPrefs {
  const AppPrefs._();

  static const String _onBoardingSeenKey = 'onboarding_seen';

  /// True once the user has finished the onboarding flow, so it is only
  /// shown on the first launch.
  static Future<bool> isOnBoardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onBoardingSeenKey) ?? false;
  }

  static Future<void> setOnBoardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onBoardingSeenKey, true);
  }
}
