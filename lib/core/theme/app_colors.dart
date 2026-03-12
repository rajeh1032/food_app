import 'package:flutter/material.dart';

/// Application color palette
///
/// NOTE: These are placeholder values. Update with actual design tokens from Figma:
/// https://www.figma.com/design/RpnoWXnxqHjf0XNModtuvb/Recipe-App-UI-Design--Community---Copy-
///
/// To extract colors from Figma:
/// 1. Open the Figma file
/// 2. Check the design system/style guide page
/// 3. Extract primary, secondary, background, text, and accent colors
/// 4. Update the values below with the actual hex codes
abstract class AppColors {
  // Primary Colors - From Figma (Pizazz-500)
  static const Color primaryColor = Color(0xFFFB9400); // Orange
  static const Color primaryLight = Color(0xFFFCA726);
  static const Color primaryDark = Color(0xFFE88500);

  // Secondary Colors - Update from Figma
  static const Color secondaryColor = Color(
    0xFF4ECDC4,
  ); // Placeholder: Turquoise
  static const Color secondaryLight = Color(0xFF7EDDD6);
  static const Color secondaryDark = Color(0xFF3BABA3);

  // Background Colors - Update from Figma
  static const Color scaffoldBgColor = Color(0xFFFAFAFA);
  static const Color cardBgColor = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(0xFFF5F5F5);

  // Text Colors - Update from Figma
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textHint = Color(0xFFB2BEC3);
  static const Color textLight = Color(0xFFFFFFFF);

  // Status Colors - Update from Figma
  static const Color successColor = Color(0xFF00B894);
  static const Color errorColor = Color(0xFFD63031);
  static const Color warningColor = Color(0xFFFDCB6E);
  static const Color infoColor = Color(0xFF74B9FF);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

  // Gray Scale - Update from Figma
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // Semantic Colors for Recipe App
  static const Color ratingColor = Color(0xFFFFC107); // Star rating
  static const Color favoriteColor = Color(0xFFE91E63); // Favorite/like
  static const Color timerColor = Color(0xFF9C27B0); // Cooking time
  static const Color difficultyEasy = Color(0xFF4CAF50);
  static const Color difficultyMedium = Color(0xFFFF9800);
  static const Color difficultyHard = Color(0xFFF44336);
}
