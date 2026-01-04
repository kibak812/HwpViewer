import 'package:path/path.dart' as p;
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/file_utils.dart';

/// File item model for file browser
class FileItem {
  final String path;
  final String name;
  final int size;
  final FileType fileType;
  final DateTime? modifiedAt;
  final bool isDirectory;

  const FileItem({
    required this.path,
    required this.name,
    required this.size,
    required this.fileType,
    this.modifiedAt,
    this.isDirectory = false,
  });

  /// Create from file path
  factory FileItem.fromPath(String filePath, {int size = 0, DateTime? modifiedAt}) {
    // Use path package for reliable path handling
    String name = p.basename(filePath);
    // Sanitize file name for security
    name = FileUtils.sanitizeFileName(name);

    final extension = p.extension(filePath).replaceFirst('.', '').toLowerCase();
    final fileType = FileTypeExtension.fromExtension(extension);

    return FileItem(
      path: filePath,
      name: name,
      size: size,
      fileType: fileType,
      modifiedAt: modifiedAt,
    );
  }

  /// Check if file is supported
  bool get isSupported => fileType != FileType.unknown;

  /// Get file extension
  String get extension {
    if (name.contains('.')) {
      return name.split('.').last.toLowerCase();
    }
    return '';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FileItem && other.path == path;
  }

  @override
  int get hashCode => path.hashCode;
}
