import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:xml/xml.dart';
import '../../../../core/errors/app_exceptions.dart';

/// Service for parsing HWP and HWPX files to HTML
class HwpParserService {
  /// Parse HWP/HWPX file bytes to HTML
  /// Uses Isolate for large files to prevent UI blocking
  Future<String> parseToHtml(Uint8List bytes, String extension) async {
    // Use isolate for files larger than 100KB to avoid blocking UI
    if (bytes.length > 100 * 1024) {
      return await compute(_parseInBackground, _ParseParams(bytes, extension));
    }

    return _parseSync(bytes, extension);
  }

  /// Synchronous parsing for small files
  static String _parseSync(Uint8List bytes, String extension) {
    switch (extension.toLowerCase()) {
      case 'hwpx':
        return _parseHwpxToHtmlSync(bytes);
      case 'hwp':
        return _parseHwpToHtmlSync(bytes);
      default:
        throw HwpParseException('Unsupported file format', details: extension);
    }
  }

  /// Background parsing function for compute()
  static String _parseInBackground(_ParseParams params) {
    return _parseSync(params.bytes, params.extension);
  }

  /// Parse HWPX (XML-based) to HTML - static version for Isolate
  static String _parseHwpxToHtmlSync(Uint8List bytes) {
    try {
      // HWPX is a ZIP archive containing XML files
      final archive = ZipDecoder().decodeBytes(bytes);

      // Find the main content file
      ArchiveFile? contentFile;
      for (final file in archive) {
        if (file.name.contains('section') && file.name.endsWith('.xml')) {
          contentFile = file;
          break;
        }
        if (file.name == 'Contents/content.xml') {
          contentFile = file;
          break;
        }
      }

      if (contentFile == null) {
        // Try to find any XML with content
        for (final file in archive) {
          if (file.name.endsWith('.xml') && !file.name.contains('settings')) {
            contentFile = file;
            break;
          }
        }
      }

      if (contentFile == null) {
        throw HwpParseException('Content file not found in HWPX archive');
      }

      final xmlContent = utf8.decode(contentFile.content, allowMalformed: true);
      return _convertOwpmlToHtml(xmlContent);
    } catch (e) {
      throw HwpParseException('Failed to parse HWPX', details: e.toString());
    }
  }

  /// Convert OWPML (HWPX XML format) to HTML
  static String _convertOwpmlToHtml(String xmlContent) {
    try {
      final document = XmlDocument.parse(xmlContent);
      final buffer = StringBuffer();

      // Process all paragraph elements
      final paragraphs = document.findAllElements('hp:p');
      if (paragraphs.isEmpty) {
        // Try alternative element names
        _processGenericXml(document.rootElement, buffer);
      } else {
        for (final para in paragraphs) {
          buffer.write('<p>');
          _processParagraph(para, buffer);
          buffer.write('</p>');
        }
      }

      // Process tables
      final tables = document.findAllElements('hp:tbl');
      for (final table in tables) {
        _processTable(table, buffer);
      }

      final result = buffer.toString();
      if (result.trim().isEmpty) {
        return '<p>문서 내용을 표시할 수 없습니다.</p>';
      }
      return result;
    } catch (e) {
      // If XML parsing fails, try to extract text content
      return _extractTextContent(xmlContent);
    }
  }

  static void _processGenericXml(XmlElement element, StringBuffer buffer) {
    for (final child in element.children) {
      if (child is XmlText) {
        final text = child.value.trim();
        if (text.isNotEmpty) {
          buffer.write(text);
        }
      } else if (child is XmlElement) {
        final tagName = child.name.local.toLowerCase();

        if (tagName == 'p' || tagName.contains('para')) {
          buffer.write('<p>');
          _processGenericXml(child, buffer);
          buffer.write('</p>');
        } else if (tagName == 't' || tagName.contains('text') || tagName.contains('run')) {
          _processGenericXml(child, buffer);
        } else if (tagName == 'table' || tagName == 'tbl') {
          buffer.write('<table>');
          _processGenericXml(child, buffer);
          buffer.write('</table>');
        } else if (tagName == 'tr' || tagName == 'row') {
          buffer.write('<tr>');
          _processGenericXml(child, buffer);
          buffer.write('</tr>');
        } else if (tagName == 'tc' || tagName == 'cell') {
          buffer.write('<td>');
          _processGenericXml(child, buffer);
          buffer.write('</td>');
        } else {
          _processGenericXml(child, buffer);
        }
      }
    }
  }

  static void _processParagraph(XmlElement para, StringBuffer buffer) {
    // Process text runs within paragraph
    final runs = para.findAllElements('hp:run');
    if (runs.isEmpty) {
      // Try direct text content
      final texts = para.findAllElements('hp:t');
      for (final text in texts) {
        buffer.write(_escapeHtml(text.innerText));
      }

      // Also check for direct text
      if (texts.isEmpty) {
        buffer.write(_escapeHtml(para.innerText));
      }
    } else {
      for (final run in runs) {
        final texts = run.findAllElements('hp:t');
        for (final text in texts) {
          buffer.write(_escapeHtml(text.innerText));
        }
      }
    }
  }

  static void _processTable(XmlElement table, StringBuffer buffer) {
    buffer.write('<table>');

    final rows = table.findAllElements('hp:tr');
    for (final row in rows) {
      buffer.write('<tr>');

      final cells = row.findAllElements('hp:tc');
      for (final cell in cells) {
        buffer.write('<td>');

        final paras = cell.findAllElements('hp:p');
        for (final para in paras) {
          _processParagraph(para, buffer);
        }

        buffer.write('</td>');
      }

      buffer.write('</tr>');
    }

    buffer.write('</table>');
  }

  static String _extractTextContent(String xmlContent) {
    // Remove XML tags and extract text
    final text = xmlContent
        .replaceAll(RegExp(r'<[^>]+>'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    if (text.isEmpty) {
      return '<p>문서 내용을 표시할 수 없습니다.</p>';
    }

    // Split into paragraphs
    final paragraphs = text.split(RegExp(r'[.!?]\s+'));
    final buffer = StringBuffer();

    for (final para in paragraphs) {
      if (para.trim().isNotEmpty) {
        buffer.write('<p>${_escapeHtml(para.trim())}</p>');
      }
    }

    return buffer.toString();
  }

  /// Parse HWP 5.0 (binary format) to HTML - static version for Isolate
  static String _parseHwpToHtmlSync(Uint8List bytes) {
    try {
      // HWP 5.0 is based on OLE2 Compound Document format
      // This is a simplified parser that extracts text content

      // Check for HWP signature
      if (bytes.length < 8) {
        throw HwpParseException('Invalid HWP file: too small');
      }

      // OLE2 signature: D0 CF 11 E0 A1 B1 1A E1
      final ole2Signature = [0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1];
      bool isOle2 = true;
      for (int i = 0; i < ole2Signature.length && i < bytes.length; i++) {
        if (bytes[i] != ole2Signature[i]) {
          isOle2 = false;
          break;
        }
      }

      if (!isOle2) {
        // Try to extract text directly if not OLE2
        return _extractTextFromBinary(bytes);
      }

      // For OLE2 HWP files, we'll attempt to extract readable text
      return _parseOle2Hwp(bytes);
    } catch (e) {
      throw HwpParseException('Failed to parse HWP', details: e.toString());
    }
  }

  static String _parseOle2Hwp(Uint8List bytes) {
    // Simplified OLE2 HWP parser
    // In production, you'd want to use a proper OLE2 library

    final textContent = _extractTextFromBinary(bytes);

    if (textContent.trim().isEmpty) {
      return '''
<div style="text-align: center; padding: 40px;">
  <p style="font-size: 18px; color: #666;">이 HWP 파일의 내용을 표시할 수 없습니다.</p>
  <p style="font-size: 14px; color: #999; margin-top: 16px;">
    HWP 5.0 바이너리 형식은 제한적으로 지원됩니다.<br>
    HWPX 형식의 파일을 사용하면 더 나은 호환성을 제공합니다.
  </p>
</div>
''';
    }

    return textContent;
  }

  static String _extractTextFromBinary(Uint8List bytes) {
    final buffer = StringBuffer();
    final textBuffer = StringBuffer();

    // Try to find Korean text (UTF-16LE encoded)
    // Use while loop with manual index control to avoid bounds issues
    int i = 0;
    final maxIndex = bytes.length - 1;

    while (i < maxIndex) {
      // Check for Hangul syllables range (AC00-D7AF in UTF-16LE)
      if (bytes[i + 1] >= 0xAC && bytes[i + 1] <= 0xD7) {
        final charCode = bytes[i] | (bytes[i + 1] << 8);
        if (charCode >= 0xAC00 && charCode <= 0xD7AF) {
          textBuffer.write(String.fromCharCode(charCode));
          i += 2; // Skip both bytes as we consumed them
          continue;
        }
      }

      // Check for basic ASCII printable characters (UTF-16LE: low byte is char, high byte is 0)
      if (bytes[i] >= 0x20 && bytes[i] <= 0x7E && bytes[i + 1] == 0) {
        textBuffer.write(String.fromCharCode(bytes[i]));
        i += 2; // Skip both bytes
        continue;
      }

      // Add paragraph break on certain patterns
      if (textBuffer.length > 50 && (bytes[i] == 0x0D || bytes[i] == 0x0A)) {
        if (textBuffer.toString().trim().isNotEmpty) {
          buffer.write('<p>${_escapeHtml(textBuffer.toString().trim())}</p>');
          textBuffer.clear();
        }
      }

      i++; // Move to next byte
    }

    // Add remaining text
    if (textBuffer.toString().trim().isNotEmpty) {
      buffer.write('<p>${_escapeHtml(textBuffer.toString().trim())}</p>');
    }

    return buffer.toString();
  }

  static String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }
}

/// Parameters for background parsing
class _ParseParams {
  final Uint8List bytes;
  final String extension;

  _ParseParams(this.bytes, this.extension);
}
