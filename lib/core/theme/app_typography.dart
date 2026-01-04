import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App typography based on modern-app-design-principles.md
class AppTypography {
  AppTypography._();

  /// Get the base text theme using Noto Sans KR (similar to Pretendard)
  static TextTheme get textTheme {
    return GoogleFonts.notoSansTextTheme().copyWith(
      displayLarge: display,
      headlineLarge: h1,
      headlineMedium: h2,
      headlineSmall: h3,
      titleLarge: bodyLarge,
      bodyLarge: body,
      bodyMedium: bodySmall,
      bodySmall: caption,
      labelSmall: overline,
    );
  }

  // Display - 36px Bold
  static TextStyle get display => GoogleFonts.notoSans(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.72,
        decoration: TextDecoration.none,
      );

  // H1 - 28px Bold
  static TextStyle get h1 => GoogleFonts.notoSans(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.3,
        letterSpacing: -0.28,
        decoration: TextDecoration.none,
      );

  // H2 - 22px SemiBold
  static TextStyle get h2 => GoogleFonts.notoSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.35,
        letterSpacing: -0.22,
        decoration: TextDecoration.none,
      );

  // H3 - 18px SemiBold
  static TextStyle get h3 => GoogleFonts.notoSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
        decoration: TextDecoration.none,
      );

  // Body Large - 17px Regular
  static TextStyle get bodyLarge => GoogleFonts.notoSans(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        height: 1.6,
        decoration: TextDecoration.none,
      );

  // Body - 15px Regular
  static TextStyle get body => GoogleFonts.notoSans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.6,
        decoration: TextDecoration.none,
      );

  // Body Small - 14px Regular
  static TextStyle get bodySmall => GoogleFonts.notoSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        decoration: TextDecoration.none,
      );

  // Caption - 12px Medium
  static TextStyle get caption => GoogleFonts.notoSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.12,
        decoration: TextDecoration.none,
      );

  // Overline - 11px SemiBold
  static TextStyle get overline => GoogleFonts.notoSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0.55,
        decoration: TextDecoration.none,
      );
}
