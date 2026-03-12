import 'package:shared_preferences/shared_preferences.dart';

/// Shared Preferences service for persistent storage
class SharedPrefService {
  static final SharedPrefService _instance = SharedPrefService._internal();
  late SharedPreferences _prefs;

  // Keys
  static const String tokenKey = 'tokenKey';
  static const String userIdKey = 'userIdKey';
  static const String onBoardingKey = 'onBoardingKey';
  static const String languageKey = 'languageKey';
  static const String themeKey = 'themeKey';

  SharedPrefService._internal();

  static SharedPrefService get instance => _instance;

  /// Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Token methods
  String? getToken() => _prefs.getString(tokenKey);

  Future<void> setToken(String token) async {
    await _prefs.setString(tokenKey, token);
  }

  Future<void> clearToken() async {
    await _prefs.remove(tokenKey);
  }

  // User ID methods
  String? getUserId() => _prefs.getString(userIdKey);

  Future<void> setUserId(String userId) async {
    await _prefs.setString(userIdKey, userId);
  }

  Future<void> clearUserId() async {
    await _prefs.remove(userIdKey);
  }

  // OnBoarding methods
  bool hasSeenOnBoarding() => _prefs.getBool(onBoardingKey) ?? false;

  Future<void> setOnBoardingSeen() async {
    await _prefs.setBool(onBoardingKey, true);
  }

  // Language methods
  String? getLanguage() => _prefs.getString(languageKey);

  Future<void> setLanguage(String languageCode) async {
    await _prefs.setString(languageKey, languageCode);
  }

  // Theme methods
  bool isDarkMode() => _prefs.getBool(themeKey) ?? false;

  Future<void> setDarkMode(bool isDark) async {
    await _prefs.setBool(themeKey, isDark);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
