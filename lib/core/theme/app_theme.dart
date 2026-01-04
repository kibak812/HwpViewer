import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_typography.dart';
import 'app_radius.dart';

/// App theme configuration based on modern-app-design-principles.md
class AppTheme {
  AppTheme._();

  /// Light theme
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: AppTypography.textTheme,

        // Colors
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          onPrimary: AppColors.white,
          secondary: AppColors.gray600,
          surface: AppColors.background,
          error: AppColors.error,
        ),

        scaffoldBackgroundColor: AppColors.background,
        dividerColor: AppColors.divider,

        // AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          titleTextStyle: AppTypography.h3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),

        // Elevated Button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            minimumSize: const Size(0, 48),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.buttonRadius,
            ),
            textStyle: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
          ),
        ),

        // Text Button
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            minimumSize: const Size(0, 48),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            textStyle: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
          ),
        ),

        // Input Decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: AppRadius.inputRadius,
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.inputRadius,
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.inputRadius,
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          hintStyle: AppTypography.body.copyWith(color: AppColors.gray400),
        ),

        // Card
        cardTheme: CardThemeData(
          color: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.cardRadius,
          ),
        ),

        // Bottom Navigation Bar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.gray400,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),

        // List Tile
        listTileTheme: ListTileThemeData(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.cardRadius,
          ),
        ),

        // Cupertino override
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: AppColors.primary,
          brightness: Brightness.light,
        ),
      );

  /// Dark theme
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: AppTypography.textTheme.apply(
          bodyColor: AppColorsDark.textPrimary,
          displayColor: AppColorsDark.textPrimary,
        ),

        // Colors
        colorScheme: const ColorScheme.dark(
          primary: AppColorsDark.primary,
          onPrimary: AppColors.white,
          secondary: AppColors.gray400,
          surface: AppColorsDark.background,
          error: AppColors.error,
        ),

        scaffoldBackgroundColor: AppColorsDark.background,
        dividerColor: AppColorsDark.divider,

        // AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: AppColorsDark.background,
          foregroundColor: AppColorsDark.textPrimary,
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleTextStyle: AppTypography.h3.copyWith(
            color: AppColorsDark.textPrimary,
          ),
        ),

        // Elevated Button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColorsDark.primary,
            foregroundColor: AppColors.white,
            minimumSize: const Size(0, 48),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.buttonRadius,
            ),
          ),
        ),

        // Text Button
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColorsDark.primary,
            minimumSize: const Size(0, 48),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),

        // Input Decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColorsDark.surface,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: AppRadius.inputRadius,
            borderSide: const BorderSide(color: AppColorsDark.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.inputRadius,
            borderSide: const BorderSide(color: AppColorsDark.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.inputRadius,
            borderSide: const BorderSide(color: AppColorsDark.primary, width: 2),
          ),
        ),

        // Card
        cardTheme: CardThemeData(
          color: AppColorsDark.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.cardRadius,
            side: const BorderSide(
              color: AppColorsDark.border,
              width: 1,
            ),
          ),
        ),

        // Bottom Navigation Bar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColorsDark.surface,
          selectedItemColor: AppColorsDark.primary,
          unselectedItemColor: AppColors.gray500,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),

        // List Tile
        listTileTheme: ListTileThemeData(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.cardRadius,
          ),
        ),

        // Cupertino override
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: AppColorsDark.primary,
          brightness: Brightness.dark,
        ),
      );
}
