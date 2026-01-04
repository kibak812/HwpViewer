import 'package:flutter_test/flutter_test.dart';
import 'package:hwp_viewer/core/errors/app_exceptions.dart';

void main() {
  group('AppExceptions', () {
    group('FileNotFoundException', () {
      test('should contain file path in message', () {
        const exception = FileNotFoundException('/path/to/file.hwp');
        expect(exception.message, equals('File not found'));
        expect(exception.filePath, equals('/path/to/file.hwp'));
        expect(exception.details, equals('/path/to/file.hwp'));
      });

      test('should have correct string representation', () {
        const exception = FileNotFoundException('/path/to/file.hwp');
        expect(
          exception.toString(),
          contains('FileNotFoundException'),
        );
      });
    });

    group('UnsupportedFileException', () {
      test('should contain extension in message', () {
        const exception = UnsupportedFileException('pdf');
        expect(exception.message, equals('Unsupported file format'));
        expect(exception.extension, equals('pdf'));
        expect(exception.details, equals('pdf'));
      });
    });

    group('HwpParseException', () {
      test('should contain parsing error details', () {
        const exception = HwpParseException(
          'Failed to parse document',
          details: 'Invalid XML structure',
        );
        expect(exception.message, equals('Failed to parse document'));
        expect(exception.details, equals('Invalid XML structure'));
      });
    });

    group('InvalidPathException', () {
      test('should contain path and reason', () {
        const exception = InvalidPathException(
          '/etc/passwd',
          reason: 'Path traversal detected',
        );
        expect(exception.message, equals('Invalid file path'));
        expect(exception.filePath, equals('/etc/passwd'));
        expect(exception.details, equals('Path traversal detected'));
      });

      test('should use file path as details when no reason provided', () {
        const exception = InvalidPathException('/etc/passwd');
        expect(exception.details, equals('/etc/passwd'));
      });
    });

    group('DatabaseException', () {
      test('should contain database error details', () {
        const exception = DatabaseException(
          'Failed to insert record',
          details: 'UNIQUE constraint failed',
        );
        expect(exception.message, equals('Failed to insert record'));
        expect(exception.details, equals('UNIQUE constraint failed'));
      });
    });
  });

  group('AppLogger', () {
    test('should not throw when logging error', () {
      expect(
        () => AppLogger.error('Test error', error: 'details'),
        returnsNormally,
      );
    });

    test('should not throw when logging warning', () {
      expect(
        () => AppLogger.warning('Test warning'),
        returnsNormally,
      );
    });

    test('should not throw when logging info', () {
      expect(
        () => AppLogger.info('Test info'),
        returnsNormally,
      );
    });
  });
}
