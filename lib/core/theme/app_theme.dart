import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_styles.dart';

/// Application theme configuration
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // Color Scheme
    scaffoldBackgroundColor: AppColors.scaffoldBgColor,
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      surface: AppColors.surfaceColor,
      error: AppColors.errorColor,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.textPrimary,
      onError: AppColors.white,
    ),

    // Typography
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: TextTheme(
      displayLarge: AppStyles.displayLarge,
      displayMedium: AppStyles.displayMedium,
      displaySmall: AppStyles.displaySmall,
      headlineLarge: AppStyles.headlineLarge,
      headlineMedium: AppStyles.headlineMedium,
      headlineSmall: AppStyles.headlineSmall,
      titleLarge: AppStyles.titleLarge,
      titleMedium: AppStyles.titleMedium,
      titleSmall: AppStyles.titleSmall,
      bodyLarge: AppStyles.bodyLarge,
      bodyMedium: AppStyles.bodyMedium,
      bodySmall: AppStyles.bodySmall,
      labelLarge: AppStyles.labelLarge,
      labelMedium: AppStyles.labelMedium,
      labelSmall: AppStyles.labelSmall,
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppStyles.headlineMedium,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      surfaceTintColor: Colors.transparent,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.cardBgColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.errorColor, width: 1),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: AppStyles.bodyMedium.copyWith(color: AppColors.textHint),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: AppStyles.buttonMedium,
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: AppStyles.buttonMedium,
      ),
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: AppColors.textPrimary, size: 24),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: AppColors.gray300,
      thickness: 1,
      space: 1,
    ),
  );
}
