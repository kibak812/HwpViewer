import 'dart:io';
import 'package:path/path.dart' as path;
import '../constants/app_constants.dart';
import '../errors/app_exceptions.dart';

/// File utility functions
class FileUtils {
  FileUtils._();

  /// Blocked path prefixes for security (iOS/macOS specific)
  static const List<String> _blockedPathPrefixes = [
    '/etc/',
    '/System/',
    '/Library/Preferences/',
    '/private/etc/',
  ];

  /// Validate file path for security
  /// Returns true if path is safe, throws InvalidPathException otherwise
  static bool validateFilePath(String filePath) {
    // Normalize the path
    final normalizedPath = path.normalize(filePath);

    // Check for path traversal attempts
    if (normalizedPath.contains('..')) {
      throw InvalidPathException(
        filePath,
        reason: 'Path traversal detected',
      );
    }

    // Check for blocked system paths
    for (final blocked in _blockedPathPrefixes) {
      if (normalizedPath.startsWith(blocked)) {
        throw InvalidPathException(
          filePath,
          reason: 'Access to system path denied',
        );
      }
    }

    // Verify file extension is supported
    final extension = getExtension(normalizedPath);
    if (extension.isNotEmpty && !AppConstants.supportedExtensions.contains(extension)) {
      throw UnsupportedFileException(extension);
    }

    return true;
  }

  /// Check if file path is valid without throwing
  static bool isValidFilePath(String filePath) {
    try {
      return validateFilePath(filePath);
    } catch (e) {
      return false;
    }
  }

  /// Sanitize file name - remove control characters and limit length
  static String sanitizeFileName(String fileName) {
    // Remove control characters
    String sanitized = fileName.replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '');

    // Limit length
    if (sanitized.length > 255) {
      sanitized = sanitized.substring(0, 255);
    }

    // Ensure not empty
    if (sanitized.isEmpty) {
      sanitized = 'unnamed_file';
    }

    return sanitized;
  }

  /// Check if file is a supported HWP file
  static bool isSupportedFile(String filePath) {
    final extension = path.extension(filePath).toLowerCase().replaceAll('.', '');
    return AppConstants.supportedExtensions.contains(extension);
  }

  /// Get file extension without dot
  static String getExtension(String filePath) {
    return path.extension(filePath).toLowerCase().replaceAll('.', '');
  }

  /// Get file name without extension
  static String getFileName(String filePath) {
    return path.basenameWithoutExtension(filePath);
  }

  /// Get file name with extension
  static String getFileNameWithExtension(String filePath) {
    return path.basename(filePath);
  }

  /// Get file type from path
  static FileType getFileType(String filePath) {
    final extension = getExtension(filePath);
    return FileTypeExtension.fromExtension(extension);
  }

  /// Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  /// Get file size
  static Future<int> getFileSize(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.length();
      }
    } catch (e) {
      // Ignore errors
    }
    return 0;
  }

  /// Check if file exists
  static Future<bool> fileExists(String filePath) async {
    try {
      return await File(filePath).exists();
    } catch (e) {
      return false;
    }
  }

  /// Read file as bytes
  static Future<List<int>?> readFileBytes(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.readAsBytes();
      }
    } catch (e) {
      // Ignore errors
    }
    return null;
  }

  /// Truncate file name if too long
  static String truncateFileName(String fileName, {int maxLength = 40}) {
    if (fileName.length <= maxLength) {
      return fileName;
    }

    final extension = path.extension(fileName);
    final nameWithoutExt = path.basenameWithoutExtension(fileName);
    final availableLength = maxLength - extension.length - 3; // 3 for "..."

    if (availableLength <= 0) {
      return '...${extension.isNotEmpty ? extension : ''}';
    }

    return '${nameWithoutExt.substring(0, availableLength)}...$extension';
  }
}
