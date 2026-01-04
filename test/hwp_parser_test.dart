import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hwp_viewer/features/viewer/domain/services/hwp_parser_service.dart';

void main() {
  late HwpParserService parser;

  setUp(() {
    parser = HwpParserService();
  });

  group('HwpParserService', () {
    group('HWPX parsing', () {
      test('should parse simple HWPX content with hp:p elements', () async {
        // Create a mock HWPX file (ZIP with XML content)
        final xmlContent = '''<?xml version="1.0" encoding="UTF-8"?>
<sec xmlns:hp="http://www.hancom.co.kr/hwpml/2011/paragraph">
  <hp:p>
    <hp:run>
      <hp:t>Hello World</hp:t>
    </hp:run>
  </hp:p>
  <hp:p>
    <hp:run>
      <hp:t>This is a test document.</hp:t>
    </hp:run>
  </hp:p>
</sec>''';

        final hwpxBytes = _createMockHwpx('Contents/section0.xml', xmlContent);
        final result = await parser.parseToHtml(hwpxBytes, 'hwpx');

        expect(result, contains('Hello World'));
        expect(result, contains('This is a test document'));
        expect(result, contains('<p>'));
      });

      test('should parse HWPX with table elements', () async {
        final xmlContent = '''<?xml version="1.0" encoding="UTF-8"?>
<sec xmlns:hp="http://www.hancom.co.kr/hwpml/2011/paragraph">
  <hp:tbl>
    <hp:tr>
      <hp:tc>
        <hp:p><hp:run><hp:t>Cell 1</hp:t></hp:run></hp:p>
      </hp:tc>
      <hp:tc>
        <hp:p><hp:run><hp:t>Cell 2</hp:t></hp:run></hp:p>
      </hp:tc>
    </hp:tr>
  </hp:tbl>
</sec>''';

        final hwpxBytes = _createMockHwpx('Contents/section0.xml', xmlContent);
        final result = await parser.parseToHtml(hwpxBytes, 'hwpx');

        expect(result, contains('<table>'));
        expect(result, contains('<tr>'));
        expect(result, contains('<td>'));
        expect(result, contains('Cell 1'));
        expect(result, contains('Cell 2'));
      });

      test('should handle empty HWPX gracefully', () async {
        final xmlContent = '''<?xml version="1.0" encoding="UTF-8"?>
<sec xmlns:hp="http://www.hancom.co.kr/hwpml/2011/paragraph">
</sec>''';

        final hwpxBytes = _createMockHwpx('Contents/section0.xml', xmlContent);
        final result = await parser.parseToHtml(hwpxBytes, 'hwpx');

        // Should return empty paragraph message or empty content
        expect(result, isNotNull);
      });

      test('should escape HTML special characters', () async {
        final xmlContent = '''<?xml version="1.0" encoding="UTF-8"?>
<sec xmlns:hp="http://www.hancom.co.kr/hwpml/2011/paragraph">
  <hp:p>
    <hp:run>
      <hp:t>Test &lt;script&gt;alert("xss")&lt;/script&gt;</hp:t>
    </hp:run>
  </hp:p>
</sec>''';

        final hwpxBytes = _createMockHwpx('Contents/section0.xml', xmlContent);
        final result = await parser.parseToHtml(hwpxBytes, 'hwpx');

        // Should not contain raw script tags
        expect(result, isNot(contains('<script>')));
        expect(result, contains('&lt;script&gt;'));
      });

      test('should handle Korean text', () async {
        final xmlContent = '''<?xml version="1.0" encoding="UTF-8"?>
<sec xmlns:hp="http://www.hancom.co.kr/hwpml/2011/paragraph">
  <hp:p>
    <hp:run>
      <hp:t>안녕하세요. 한글 문서입니다.</hp:t>
    </hp:run>
  </hp:p>
</sec>''';

        final hwpxBytes = _createMockHwpx('Contents/section0.xml', xmlContent);
        final result = await parser.parseToHtml(hwpxBytes, 'hwpx');

        expect(result, contains('안녕하세요'));
        expect(result, contains('한글 문서입니다'));
      });
    });

    group('HWP 5.0 parsing', () {
      test('should detect non-OLE2 files', () async {
        // Random bytes that are not OLE2
        final bytes = Uint8List.fromList([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09]);

        final result = await parser.parseToHtml(bytes, 'hwp');
        // Should not throw, but return empty or error message
        expect(result, isNotNull);
      });

      test('should handle OLE2 signature detection', () async {
        // OLE2 signature: D0 CF 11 E0 A1 B1 1A E1
        final bytes = Uint8List.fromList([
          0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1,
          // Add some padding
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        ]);

        final result = await parser.parseToHtml(bytes, 'hwp');
        // Should recognize as OLE2 and return something (even if empty)
        expect(result, isNotNull);
      });

      test('should throw for too small files', () async {
        final bytes = Uint8List.fromList([0x00, 0x01, 0x02]);

        expect(
          () => parser.parseToHtml(bytes, 'hwp'),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('Unsupported formats', () {
      test('should throw for unsupported file extensions', () {
        final bytes = Uint8List.fromList([0x00, 0x01, 0x02, 0x03]);

        expect(
          () => parser.parseToHtml(bytes, 'doc'),
          throwsA(isA<UnsupportedError>()),
        );
      });

      test('should throw for pdf extension', () {
        final bytes = Uint8List.fromList([0x25, 0x50, 0x44, 0x46]); // %PDF

        expect(
          () => parser.parseToHtml(bytes, 'pdf'),
          throwsA(isA<UnsupportedError>()),
        );
      });
    });
  });
}

/// Create a mock HWPX file (ZIP archive) with the given XML content
Uint8List _createMockHwpx(String filename, String xmlContent) {
  final archive = Archive();

  // Add the XML file to the archive
  final bytes = utf8.encode(xmlContent);
  final file = ArchiveFile(filename, bytes.length, bytes);
  archive.addFile(file);

  // Encode as ZIP
  final zipData = ZipEncoder().encode(archive);
  return Uint8List.fromList(zipData);
}
