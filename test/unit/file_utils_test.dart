import 'package:flutter_test/flutter_test.dart';
import 'package:hwp_viewer/core/utils/file_utils.dart';
import 'package:hwp_viewer/core/errors/app_exceptions.dart';

void main() {
  group('FileUtils', () {
    group('validateFilePath', () {
      test('should return true for valid HWP file path', () {
        expect(
          FileUtils.validateFilePath('/Users/test/document.hwp'),
          isTrue,
        );
      });

      test('should return true for valid HWPX file path', () {
        expect(
          FileUtils.validateFilePath('/Users/test/document.hwpx'),
          isTrue,
        );
      });

      test('should throw InvalidPathException for path traversal attempt', () {
        expect(
          () => FileUtils.validateFilePath('/Users/../etc/passwd'),
          throwsA(isA<InvalidPathException>()),
        );
      });

      test('should throw InvalidPathException for blocked system path', () {
        expect(
          () => FileUtils.validateFilePath('/etc/passwd'),
          throwsA(isA<InvalidPathException>()),
        );
      });

      test('should throw UnsupportedFileException for unsupported extension', () {
        expect(
          () => FileUtils.validateFilePath('/Users/test/document.pdf'),
          throwsA(isA<UnsupportedFileException>()),
        );
      });
    });

    group('isValidFilePath', () {
      test('should return true for valid paths', () {
        expect(FileUtils.isValidFilePath('/Users/test/document.hwp'), isTrue);
      });

      test('should return false for invalid paths without throwing', () {
        expect(FileUtils.isValidFilePath('/etc/passwd'), isFalse);
        expect(FileUtils.isValidFilePath('/Users/../etc/passwd'), isFalse);
      });
    });

    group('sanitizeFileName', () {
      test('should remove control characters', () {
        expect(
          FileUtils.sanitizeFileName('test\x00\x1Ffile.hwp'),
          equals('testfile.hwp'),
        );
      });

      test('should limit file name length to 255 characters', () {
        final longName = 'a' * 300;
        expect(
          FileUtils.sanitizeFileName(longName).length,
          equals(255),
        );
      });

      test('should return unnamed_file for empty input', () {
        expect(
          FileUtils.sanitizeFileName(''),
          equals('unnamed_file'),
        );
      });

      test('should return normal file names unchanged', () {
        expect(
          FileUtils.sanitizeFileName('document.hwp'),
          equals('document.hwp'),
        );
      });
    });

    group('isSupportedFile', () {
      test('should return true for HWP files', () {
        expect(FileUtils.isSupportedFile('/path/to/file.hwp'), isTrue);
      });

      test('should return true for HWPX files', () {
        expect(FileUtils.isSupportedFile('/path/to/file.hwpx'), isTrue);
      });

      test('should return false for unsupported files', () {
        expect(FileUtils.isSupportedFile('/path/to/file.pdf'), isFalse);
        expect(FileUtils.isSupportedFile('/path/to/file.docx'), isFalse);
      });

      test('should be case insensitive', () {
        expect(FileUtils.isSupportedFile('/path/to/file.HWP'), isTrue);
        expect(FileUtils.isSupportedFile('/path/to/file.HWPX'), isTrue);
      });
    });

    group('formatFileSize', () {
      test('should format bytes correctly', () {
        expect(FileUtils.formatFileSize(500), equals('500 B'));
      });

      test('should format kilobytes correctly', () {
        expect(FileUtils.formatFileSize(1024), equals('1.0 KB'));
        expect(FileUtils.formatFileSize(1536), equals('1.5 KB'));
      });

      test('should format megabytes correctly', () {
        expect(FileUtils.formatFileSize(1048576), equals('1.0 MB'));
      });

      test('should format gigabytes correctly', () {
        expect(FileUtils.formatFileSize(1073741824), equals('1.0 GB'));
      });
    });

    group('truncateFileName', () {
      test('should not truncate short file names', () {
        expect(
          FileUtils.truncateFileName('short.hwp'),
          equals('short.hwp'),
        );
      });

      test('should truncate long file names', () {
        final longName = 'a' * 50 + '.hwp';
        final result = FileUtils.truncateFileName(longName, maxLength: 20);
        expect(result.length, lessThanOrEqualTo(20));
        expect(result, contains('...'));
        expect(result, endsWith('.hwp'));
      });

      test('should handle very small maxLength', () {
        final result = FileUtils.truncateFileName('test.hwp', maxLength: 5);
        expect(result, equals('....hwp'));
      });
    });

    group('getExtension', () {
      test('should extract extension correctly', () {
        expect(FileUtils.getExtension('/path/to/file.hwp'), equals('hwp'));
        expect(FileUtils.getExtension('/path/to/file.HWPX'), equals('hwpx'));
      });

      test('should return empty for files without extension', () {
        expect(FileUtils.getExtension('/path/to/file'), equals(''));
      });
    });

    group('getFileName', () {
      test('should extract file name without extension', () {
        expect(
          FileUtils.getFileName('/path/to/document.hwp'),
          equals('document'),
        );
      });
    });

    group('getFileNameWithExtension', () {
      test('should extract full file name', () {
        expect(
          FileUtils.getFileNameWithExtension('/path/to/document.hwp'),
          equals('document.hwp'),
        );
      });
    });
  });
}
