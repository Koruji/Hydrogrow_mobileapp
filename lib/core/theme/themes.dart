import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'DMSans',
    brightness: Brightness.light,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.menu,
      brightness: Brightness.light,

      primary: AppColors.menu,
      secondary: AppColors.textSecondary,
      surface: AppColors.background,
      error: AppColors.warning,
    ),

    scaffoldBackgroundColor: AppColors.background,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.menu,
      foregroundColor: AppColors.titleText,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.titleText),
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: AppColors.textPrimary),
      bodyMedium: TextStyle(color: AppColors.textSecondary),
      labelLarge: TextStyle(
        color: AppColors.titleText,
        fontWeight: FontWeight.w600,
      ),
    ),

    iconTheme: const IconThemeData(color: AppColors.icon),

    dividerColor: AppColors.divider,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.menu,
        foregroundColor: AppColors.titleText,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.textPrimary,
      contentTextStyle: const TextStyle(color: Colors.white),
      actionTextColor: AppColors.notification,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.menu,
      brightness: Brightness.dark,
    ),
  );
}
