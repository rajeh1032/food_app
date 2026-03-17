/// Asset path constants
abstract class AppAssets {
  // Base paths
  static const String _imgPath = 'assets/images/';
  static const String _svgPath = 'assets/svg/';

  // ==================== IMAGES ====================
  // Add your image assets here
  // Example:
  // static const String logo = '${_imgPath}logo.png';
  // static const String placeholder = '${_imgPath}placeholder.png';
  // static const String onboarding1 = '${_imgPath}onboarding_1.png';
  static const String userImage = '${_imgPath}user_image.png';

  // ==================== SVG ICONS ====================

  // Navigation Icons
  /// Home/main screen icon
  static const String homeIcon = '${_svgPath}home.svg';

  /// Search functionality icon
  static const String searchIcon = '${_svgPath}search.svg';

  /// Favorites/heart icon
  static const String favoriteIcon = '${_svgPath}favorite.svg';

  /// User profile icon
  static const String profileIcon = '${_svgPath}profile.svg';

  // Action Icons
  /// Notification bell icon
  static const String notificationIcon = '${_svgPath}notification.svg';

  /// Filter/sort icon
  static const String filterIcon = '${_svgPath}filter.svg';

  /// Back/arrow left icon
  static const String backIcon = '${_svgPath}back.svg';

  /// Bookmark/save icon
  static const String bookmarkIcon = '${_svgPath}bookmark.svg';

  /// Share icon
  static const String shareIcon = '${_svgPath}share.svg';

  /// Settings/gear icon
  static const String settingsIcon = '${_svgPath}settings.svg';

  // Recipe-Related Icons
  /// Clock/timer icon for cooking time
  static const String timeIcon = '${_svgPath}time.svg';

  /// Rating star icon
  static const String starIcon = '${_svgPath}star.svg';

  // ==================== PNG ICONS ====================
  // Add your PNG icon assets here
  // Example:
  // static const String notificationIconPng = '${_iconsPath}notification.png';

  // ==================== NOTES ====================
  // NOTE: Current SVG icons are placeholders. Replace them with actual icons from Figma:
  // 1. Open Figma: https://www.figma.com/design/RpnoWXnxqHjf0XNModtuvb/Recipe-App-UI-Design--Community---Copy-?node-id=60-1222
  // 2. Select each icon
  // 3. Export as SVG
  // 4. Replace the placeholder files in assets/svg/
  //
  // Usage Example:
  // import 'package:food_app/core/utils/svg_icon.dart';
  // import 'package:food_app/core/assets/app_assets.dart';
  //
  // SvgIcon(
  //   assetPath: AppAssets.homeIcon,
  //   width: 24,
  //   height: 24,
  //   color: AppColors.primaryColor,
  // )
}
