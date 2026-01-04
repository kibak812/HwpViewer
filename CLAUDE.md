# HWP Viewer - Project Instructions

## Project Overview
iOS HWP/HWPX file viewer app built with Flutter. Core value: ad-free, clean document viewing experience.

## Tech Stack
- **Framework**: Flutter 3.x
- **State Management**: Riverpod
- **Database**: SQLite (sqflite)
- **Document Rendering**: WebView (flutter_inappwebview)
- **Archive Handling**: archive (for HWPX zip extraction)

## Development Guidelines

### Code Conventions
- Use Riverpod for state management
- Follow Flutter naming conventions (snake_case for files, PascalCase for classes)
- Keep widgets modular and reusable
- Use feature-based folder structure under `lib/features/`

### Security Requirements
- Always escape user input before JavaScript injection (use `_escapeForJavaScript()`)
- Keep WebView file access disabled (`allowFileAccess: false`)
- Validate all indices before accessing arrays/enums
- Handle database race conditions properly

### Testing
- Unit tests in `test/unit/`
- Run tests before committing: `flutter test`
- Run analysis: `flutter analyze`

### Build Notes
- iOS builds require macOS with Xcode
- Windows can only run `flutter analyze` and `flutter test`
- For iOS deployment, see `method.md` for detailed steps

## Important Files
- `method.md` - Error solutions and technical notes
- `CHANGELOG.md` - Version history
- `lib/core/` - Theme, constants, utilities, database
- `lib/features/` - Feature modules (file_browser, viewer, recents, settings)

## Restrictions
- NO advertisements (core differentiator)
- NO personal data collection
- HWP 5.0 binary support is limited - do not promise full compatibility
