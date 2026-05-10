import 'package:flutter/material.dart';

// ── Light constants (kept for const contexts) ───────────────────────────────
class AppColors {
  static const Color menu = Color(0xFF329D9C);
  static const Color background = Color(0xFFDDFEF0);
  static const Color surface = Colors.white;
  static const Color divider = Color(0xFF123737);
  static const Color icon = Color(0xFF123737);
  static const Color textPrimary = Color(0xFF123737);
  static const Color textSecondary = Color(0xFF329D9C);
  static const Color titleText = Color(0xFFFFFFFF);
  static const Color warning = Color(0xFFCE4B4B);
  static const Color notification = Color(0xFFCE984B);
  static const Color success = Color(0xFF4BCE68);
}

// ── Dark constants ───────────────────────────────────────────────────────────
class DarkAppColors {
  static const Color menu = Color(0xFF2E9697);
  static const Color background = Color(0xFF141E1E);
  static const Color surface = Color(0xFF1C2C2C);
  static const Color divider = Color(0xFF2A3E3E);
  static const Color icon = Color(0xFFB0CCCC);
  static const Color textPrimary = Color(0xFFD6EDEC);
  static const Color textSecondary = Color(0xFF68B8B7);
  static const Color titleText = Color(0xFFFFFFFF);
  static const Color warning = Color(0xFFD4554D);
  static const Color notification = Color(0xFFCE9850);
  static const Color success = Color(0xFF4DC86A);
}

// ── ThemeExtension ───────────────────────────────────────────────────────────
@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color menu;
  final Color background;
  final Color surface;
  final Color divider;
  final Color icon;
  final Color textPrimary;
  final Color textSecondary;
  final Color titleText;
  final Color warning;
  final Color notification;
  final Color success;

  const AppColorsExtension({
    required this.menu,
    required this.background,
    required this.surface,
    required this.divider,
    required this.icon,
    required this.textPrimary,
    required this.textSecondary,
    required this.titleText,
    required this.warning,
    required this.notification,
    required this.success,
  });

  static const light = AppColorsExtension(
    menu: AppColors.menu,
    background: AppColors.background,
    surface: AppColors.surface,
    divider: AppColors.divider,
    icon: AppColors.icon,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    titleText: AppColors.titleText,
    warning: AppColors.warning,
    notification: AppColors.notification,
    success: AppColors.success,
  );

  static const dark = AppColorsExtension(
    menu: DarkAppColors.menu,
    background: DarkAppColors.background,
    surface: DarkAppColors.surface,
    divider: DarkAppColors.divider,
    icon: DarkAppColors.icon,
    textPrimary: DarkAppColors.textPrimary,
    textSecondary: DarkAppColors.textSecondary,
    titleText: DarkAppColors.titleText,
    warning: DarkAppColors.warning,
    notification: DarkAppColors.notification,
    success: DarkAppColors.success,
  );

  @override
  AppColorsExtension copyWith({
    Color? menu,
    Color? background,
    Color? surface,
    Color? divider,
    Color? icon,
    Color? textPrimary,
    Color? textSecondary,
    Color? titleText,
    Color? warning,
    Color? notification,
    Color? success,
  }) {
    return AppColorsExtension(
      menu: menu ?? this.menu,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      divider: divider ?? this.divider,
      icon: icon ?? this.icon,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      titleText: titleText ?? this.titleText,
      warning: warning ?? this.warning,
      notification: notification ?? this.notification,
      success: success ?? this.success,
    );
  }

  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other == null) return this;
    return AppColorsExtension(
      menu: Color.lerp(menu, other.menu, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      titleText: Color.lerp(titleText, other.titleText, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      notification: Color.lerp(notification, other.notification, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}

// ── BuildContext helper ──────────────────────────────────────────────────────
extension AppColorsX on BuildContext {
  AppColorsExtension get colors =>
      Theme.of(this).extension<AppColorsExtension>() ?? AppColorsExtension.light;
}
