/// Application-wide constants
abstract class AppConstants {
  // App Info
  static const String appName = 'Recipe App';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const int apiTimeout = 30; // seconds
  static const int maxRetries = 3;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;

  // Cache Duration
  static const Duration cacheExpiration = Duration(hours: 24);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultElevation = 2.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;

  // Recipe App Specific
  static const int maxIngredientsDisplay = 10;
  static const int maxStepsDisplay = 20;
  static const List<String> difficultyLevels = ['Easy', 'Medium', 'Hard'];
  static const List<String> mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    'Dessert',
  ];
}
