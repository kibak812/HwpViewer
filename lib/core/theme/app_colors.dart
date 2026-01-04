import 'package:flutter/material.dart';

/// App color palette based on modern-app-design-principles.md
class AppColors {
  AppColors._();

  // Primary (Brand Color - Blue for trust/productivity)
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryHover = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFFDBEAFE);
  static const Color primaryDark = Color(0xFF1E40AF);

  // Neutral (Gray Scale) - Light Mode
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF4F4F5);
  static const Color gray200 = Color(0xFFE4E4E7);
  static const Color gray300 = Color(0xFFD4D4D8);
  static const Color gray400 = Color(0xFFA1A1AA);
  static const Color gray500 = Color(0xFF71717A);
  static const Color gray600 = Color(0xFF52525B);
  static const Color gray700 = Color(0xFF3F3F46);
  static const Color gray800 = Color(0xFF27272A);
  static const Color gray900 = Color(0xFF18181B);
  static const Color black = Color(0xFF09090B);

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFE0F2FE);

  // Light Mode Semantic Mappings
  static const Color background = white;
  static const Color surface = gray50;
  static const Color surfaceElevated = white;
  static const Color textPrimary = gray900;
  static const Color textSecondary = gray600;
  static const Color textTertiary = gray500;
  static const Color textDisabled = gray400;
  static const Color border = gray200;
  static const Color divider = gray100;

  // Document colors
  static const Color documentBackground = white;
  static const Color documentText = gray900;
}

/// Dark mode colors
class AppColorsDark {
  AppColorsDark._();

  static const Color background = Color(0xFF0A0A0B);
  static const Color surface = Color(0xFF18181B);
  static const Color surfaceElevated = Color(0xFF27272A);
  static const Color textPrimary = Color(0xFFEBEBEB); // 92% white
  static const Color textSecondary = Color(0xFFB8B8B8); // 72% white
  static const Color textTertiary = Color(0xFF7A7A7A); // 48% white
  static const Color textDisabled = Color(0xFF525252); // 32% white
  static const Color border = Color(0xFF27272A);
  static const Color divider = Color(0xFF27272A);
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryLight = Color(0xFF1E3A5F);

  // Document colors for dark mode
  static const Color documentBackground = Color(0xFF1A1A1A);
  static const Color documentText = Color(0xFFE5E5E5);
}
