import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Theme mode state
enum AppThemeMode {
  system,
  light,
  dark,
}

/// Theme provider state notifier
class ThemeNotifier extends StateNotifier<AppThemeMode> {
  static const String _themeKey = 'theme_mode';

  ThemeNotifier() : super(AppThemeMode.system) {
    _loadTheme();
  }

  /// Load saved theme preference
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey) ?? 0;
    // Validate index to prevent RangeError on corrupted preferences
    if (themeIndex >= 0 && themeIndex < AppThemeMode.values.length) {
      state = AppThemeMode.values[themeIndex];
    } else {
      state = AppThemeMode.system;
    }
  }

  /// Set theme mode
  Future<void> setThemeMode(AppThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
  }

  /// Get current ThemeMode for Flutter
  ThemeMode get themeMode {
    switch (state) {
      case AppThemeMode.system:
        return ThemeMode.system;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
    }
  }
}

/// Theme provider
final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  return ThemeNotifier();
});

/// Convenience extension to get display name
extension AppThemeModeExtension on AppThemeMode {
  String get displayName {
    switch (this) {
      case AppThemeMode.system:
        return '시스템 설정';
      case AppThemeMode.light:
        return '라이트 모드';
      case AppThemeMode.dark:
        return '다크 모드';
    }
  }

  IconData get icon {
    switch (this) {
      case AppThemeMode.system:
        return Icons.brightness_auto;
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
    }
  }
}
