# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

iOS HWP/HWPX file viewer app built with Flutter. Core value: ad-free, clean document viewing experience for Korean word processor files.

## Commands

```bash
# Install dependencies
flutter pub get

# Run static analysis
flutter analyze

# Run all tests
flutter test

# Run specific test file
flutter test test/unit/file_utils_test.dart

# Run tests with coverage
flutter test --coverage

# Check for outdated packages
flutter pub outdated

# Generate app icons (after updating assets/icons/app_icon.png)
dart run flutter_launcher_icons
```

**iOS builds (Mac only):**
```bash
flutter build ios --debug
flutter build ios --release
```

Windows can only run `flutter analyze` and `flutter test`.

## Architecture

### Feature-Based Structure
```
lib/
├── core/           # Shared infrastructure
│   ├── constants/  # App-wide constants, FileType enum
│   ├── database/   # SQLite (DatabaseHelper singleton, RecentFilesDao)
│   ├── errors/     # Custom exceptions + AppLogger
│   ├── theme/      # Material 3 theme system
│   └── utils/      # FileUtils with security validation
├── features/       # Each feature follows domain/data/presentation pattern
│   ├── file_browser/
│   ├── viewer/     # HwpParserService + WebView rendering
│   ├── recents/
│   └── settings/
└── shared/
    ├── providers/  # Riverpod providers (theme, recent_files)
    ├── services/   # FileHandlerService for external app integration
    └── widgets/    # Reusable widgets
```

### State Management (Riverpod)
- `themeProvider`: StateNotifierProvider managing AppThemeMode, persists to SharedPreferences
- `recentFilesProvider`: StateNotifierProvider wrapping RecentFilesDao with AsyncValue

### Document Parsing (HwpParserService)
- **HWPX**: ZIP extraction → XML parsing → HTML conversion (full support)
- **HWP 5.0**: Binary OLE2 format → text extraction only (limited support)
- Files >100KB use `compute()` Isolate to prevent UI blocking
- Output rendered in WebView with CSP headers

### Navigation
- CupertinoTabScaffold with 3 tabs: Files, Recents, Settings
- ViewerScreen opened via CupertinoPageRoute

## Security Requirements

- **XSS Prevention**: Use `_escapeForJavaScript()` and `_escapeRegExp()` before JavaScript injection
- **WebView Hardening**: Keep `allowFileAccess: false`, `allowContentAccess: false`
- **Path Validation**: FileUtils validates paths (blocks `..` traversal, system paths)
- **Enum Bounds**: Always validate indices before accessing enum values
- **Database**: Set `_database = null` before closing to prevent race conditions

## Key Files

- `method.md` - Error solutions log (11 documented issues with fixes)
- `CHANGELOG.md` - Version history
- `lib/features/viewer/domain/services/hwp_parser_service.dart` - Document parsing
- `lib/core/utils/file_utils.dart` - File validation with security checks

## Restrictions

- NO advertisements (core differentiator)
- NO personal data collection
- HWP 5.0 binary support is limited - do not promise full compatibility
