import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  // ── Light ──────────────────────────────────────────────────────────────────
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'DMSans',
    brightness: Brightness.light,
    extensions: const [AppColorsExtension.light],

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

    cardTheme: const CardThemeData(
      color: AppColors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.titleText, fontWeight: FontWeight.w500, fontSize: 36),
      titleMedium: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500, fontSize: 36),
      titleSmall: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 10),
      labelLarge: TextStyle(color: AppColors.titleText, fontWeight: FontWeight.w500, fontSize: 36),
      labelMedium: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 36),
      labelSmall: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 10),
      bodyLarge: TextStyle(color: AppColors.textPrimary),
      bodyMedium: TextStyle(color: AppColors.textSecondary),
    ),

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

  // ── Dark ───────────────────────────────────────────────────────────────────
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'DMSans',
    brightness: Brightness.dark,
    extensions: const [AppColorsExtension.dark],

    colorScheme: ColorScheme.fromSeed(
      seedColor: DarkAppColors.menu,
      brightness: Brightness.dark,
      primary: DarkAppColors.menu,
      secondary: DarkAppColors.textSecondary,
      surface: DarkAppColors.surface,
      error: DarkAppColors.warning,
    ),

    scaffoldBackgroundColor: DarkAppColors.background,

    appBarTheme: const AppBarTheme(
      backgroundColor: DarkAppColors.menu,
      foregroundColor: DarkAppColors.titleText,
      centerTitle: true,
      iconTheme: IconThemeData(color: DarkAppColors.titleText),
    ),

    cardTheme: const CardThemeData(
      color: DarkAppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(color: DarkAppColors.titleText, fontWeight: FontWeight.w500, fontSize: 36),
      titleMedium: TextStyle(color: DarkAppColors.textSecondary, fontWeight: FontWeight.w500, fontSize: 36),
      titleSmall: TextStyle(color: DarkAppColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 10),
      labelLarge: TextStyle(color: DarkAppColors.titleText, fontWeight: FontWeight.w500, fontSize: 36),
      labelMedium: TextStyle(color: DarkAppColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 36),
      labelSmall: TextStyle(color: Color(0xFF7A9A9A), fontWeight: FontWeight.w300, fontSize: 10),
      bodyLarge: TextStyle(color: DarkAppColors.textPrimary),
      bodyMedium: TextStyle(color: DarkAppColors.textSecondary),
    ),

    dividerColor: DarkAppColors.divider,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: DarkAppColors.menu,
        foregroundColor: DarkAppColors.titleText,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: DarkAppColors.surface,
      contentTextStyle: const TextStyle(color: DarkAppColors.textPrimary),
      actionTextColor: DarkAppColors.notification,
    ),
  );

  // ── Shared text styles ─────────────────────────────────────────────────────
  static const TextStyle rgpdTitleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle rgpdSectionTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle rgpdSectionContentStyle = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
    height: 1.5,
  );
}
