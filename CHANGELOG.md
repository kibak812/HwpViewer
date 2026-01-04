# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-01-04

### Added
- Initial project setup with Flutter
- HWP/HWPX file viewer functionality
- File browser with iCloud Drive support
- Document viewer with WebView rendering
- Search functionality within documents
- Recent files tracking with SQLite
- Settings screen with theme switching (Light/Dark/System)
- Share functionality for documents

### Security
- XSS prevention in search functionality with proper JavaScript escaping
- WebView security hardening (disabled file access, added CSP headers)
- ThemeProvider index range validation
- DatabaseHelper race condition fix in close()
- HWP binary parsing bounds checking
- Large file processing moved to Isolate to prevent UI blocking

### Technical
- State management: Riverpod
- Database: SQLite (sqflite)
- Document rendering: flutter_inappwebview
- Archive handling: archive package for HWPX
- XML parsing for HWPX content extraction
