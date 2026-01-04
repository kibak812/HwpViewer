/// App-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'HWP Viewer';
  static const String appNameKorean = '한글 뷰어';

  // Supported file extensions
  static const List<String> supportedExtensions = ['hwp', 'hwpx'];

  // Database
  static const String databaseName = 'hwp_viewer.db';
  static const int databaseVersion = 1;

  // Cache
  static const int maxRecentFiles = 20;
  static const int thumbnailCacheSize = 50;

  // UI
  static const int maxFileNameLength = 40;
  static const double documentMaxWidth = 800;

  // URLs
  static const String appStoreUrl = 'https://apps.apple.com/app/hwp-viewer';
  static const String supportEmail = 'support@hwpviewer.com';
  static const String privacyPolicyUrl = 'https://hwpviewer.com/privacy';
}

/// File type enum
enum FileType {
  hwp,
  hwpx,
  unknown,
}

extension FileTypeExtension on FileType {
  static FileType fromExtension(String extension) {
    switch (extension.toLowerCase()) {
      case 'hwp':
        return FileType.hwp;
      case 'hwpx':
        return FileType.hwpx;
      default:
        return FileType.unknown;
    }
  }

  String get displayName {
    switch (this) {
      case FileType.hwp:
        return 'HWP';
      case FileType.hwpx:
        return 'HWPX';
      case FileType.unknown:
        return 'Unknown';
    }
  }
}
