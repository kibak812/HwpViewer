import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hwp_viewer/shared/providers/theme_provider.dart';

void main() {
  group('ThemeNotifier', () {
    test('should start with system theme mode', () {
      final notifier = ThemeNotifier();
      expect(notifier.state, equals(AppThemeMode.system));
    });

    test('should convert AppThemeMode to ThemeMode correctly', () {
      final notifier = ThemeNotifier();

      // Initial state should be system
      expect(notifier.themeMode, equals(ThemeMode.system));
    });
  });

  group('AppThemeMode', () {
    test('should have correct display names', () {
      expect(AppThemeMode.system.displayName, equals('시스템 설정'));
      expect(AppThemeMode.light.displayName, equals('라이트 모드'));
      expect(AppThemeMode.dark.displayName, equals('다크 모드'));
    });

    test('should have correct icons', () {
      expect(AppThemeMode.system.icon, equals(Icons.brightness_auto));
      expect(AppThemeMode.light.icon, equals(Icons.light_mode));
      expect(AppThemeMode.dark.icon, equals(Icons.dark_mode));
    });
  });
}
