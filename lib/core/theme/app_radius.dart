import 'package:flutter/material.dart';

/// App border radius values based on modern-app-design-principles.md
class AppRadius {
  AppRadius._();

  // Base radius values
  static const double sm = 4;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
  static const double xxl = 24;
  static const double full = 9999;

  // Semantic radius
  static const double button = md; // 8
  static const double card = lg; // 12
  static const double modal = xl; // 16
  static const double input = md; // 8
  static const double chip = full; // pill shape
  static const double bottomSheet = xl; // 16

  // BorderRadius helpers
  static BorderRadius get buttonRadius => BorderRadius.circular(button);
  static BorderRadius get cardRadius => BorderRadius.circular(card);
  static BorderRadius get modalRadius => BorderRadius.circular(modal);
  static BorderRadius get inputRadius => BorderRadius.circular(input);
  static BorderRadius get bottomSheetRadius => const BorderRadius.vertical(
        top: Radius.circular(bottomSheet),
      );
}
