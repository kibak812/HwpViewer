import 'package:flutter/material.dart';

/// App shadow values based on modern-app-design-principles.md
class AppShadows {
  AppShadows._();

  // Light mode shadows
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0D000000), // 5% opacity
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x14000000), // 8% opacity
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x1F000000), // 12% opacity
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x29000000), // 16% opacity
      blurRadius: 32,
      offset: Offset(0, 8),
    ),
  ];

  // Semantic shadows
  static const List<BoxShadow> card = md;
  static const List<BoxShadow> cardHover = lg;
  static const List<BoxShadow> modal = xl;

  // Dark mode shadows (with border instead)
  static List<BoxShadow> get darkCard => [];
}
