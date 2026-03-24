import 'package:flutter/material.dart';

/// Application color palette based on the current Figma design.
abstract class AppColors {
  // Primary Colors
  static const Color primaryColor = Color(0xFFFB9400);
  static const Color primaryLight = Color(0xFFFCA726);
  static const Color primaryDark = Color(0xFFE88500);

  // Secondary Colors
  static const Color secondaryColor = Color(0xFFFACC15);
  static const Color secondaryLight = Color(0xFF7EDDD6);
  static const Color secondaryDark = Color(0xFF3BABA3);

  // Background Colors
  static const Color scaffoldBgColor = Color(0xFFFFFFFF);
  static const Color cardBgColor = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(0xFFF3F4F6);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);
  static const Color textLight = Color(0xFFFFFFFF);

  // Status Colors
  static const Color successColor = Color(0xFF00B894);
  static const Color errorColor = Color(0xFFDC2626);
  static const Color warningColor = Color(0xFFFACC15);
  static const Color infoColor = Color(0xFF74B9FF);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

  // Gray Scale
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF94A3B8);
  static const Color gray600 = Color(0xFF64748B);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // Semantic Colors
  static const Color ratingColor = Color(0xFFFACC15);
  static const Color favoriteColor = Color(0xFFE91E63);
  static const Color timerColor = Color(0xFF64748B);
  static const Color difficultyEasy = Color(0xFF4CAF50);
  static const Color difficultyMedium = Color(0xFFFF9800);
  static const Color difficultyHard = Color(0xFFF44336);
}
