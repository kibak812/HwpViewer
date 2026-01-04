import 'dart:developer' as developer;

/// Base exception for HWP Viewer app
abstract class AppException implements Exception {
  final String message;
  final String? details;
  final StackTrace? stackTrace;

  const AppException(this.message, {this.details, this.stackTrace});

  @override
  String toString() => '$runtimeType: $message${details != null ? ' ($details)' : ''}';

  /// Log exception for debugging
  void log() {
    developer.log(
      message,
      error: details,
      stackTrace: stackTrace,
      name: runtimeType.toString(),
    );
  }
}

/// Exception thrown when file is not found
class FileNotFoundException extends AppException {
  final String filePath;

  const FileNotFoundException(this.filePath, {super.stackTrace})
      : super('File not found', details: filePath);
}

/// Exception thrown when file format is not supported
class UnsupportedFileException extends AppException {
  final String extension;

  const UnsupportedFileException(this.extension, {super.stackTrace})
      : super('Unsupported file format', details: extension);
}

/// Exception thrown when HWP/HWPX parsing fails
class HwpParseException extends AppException {
  const HwpParseException(String message, {String? details, super.stackTrace})
      : super(message, details: details);
}

/// Exception thrown when file path is invalid or potentially malicious
class InvalidPathException extends AppException {
  final String filePath;

  const InvalidPathException(this.filePath, {String? reason, super.stackTrace})
      : super('Invalid file path', details: reason ?? filePath);
}

/// Exception thrown for database operations
class DatabaseException extends AppException {
  const DatabaseException(String message, {String? details, super.stackTrace})
      : super(message, details: details);
}

/// Utility for logging errors
class AppLogger {
  AppLogger._();

  static void error(String message, {Object? error, StackTrace? stackTrace, String? name}) {
    developer.log(
      message,
      error: error,
      stackTrace: stackTrace,
      name: name ?? 'HwpViewer',
      level: 1000, // Error level
    );
  }

  static void warning(String message, {Object? error, String? name}) {
    developer.log(
      message,
      error: error,
      name: name ?? 'HwpViewer',
      level: 900, // Warning level
    );
  }

  static void info(String message, {String? name}) {
    developer.log(
      message,
      name: name ?? 'HwpViewer',
      level: 800, // Info level
    );
  }
}
