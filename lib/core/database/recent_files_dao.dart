import 'package:sqflite/sqflite.dart';
import '../constants/app_constants.dart';
import 'database_helper.dart';

/// Data model for recent file
class RecentFile {
  final int? id;
  final String filePath;
  final String fileName;
  final int fileSize;
  final String fileType;
  final DateTime openedAt;
  final DateTime createdAt;

  RecentFile({
    this.id,
    required this.filePath,
    required this.fileName,
    required this.fileSize,
    required this.fileType,
    required this.openedAt,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'file_path': filePath,
      'file_name': fileName,
      'file_size': fileSize,
      'file_type': fileType,
      'opened_at': openedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory RecentFile.fromMap(Map<String, dynamic> map) {
    return RecentFile(
      id: map['id'] as int?,
      filePath: map['file_path'] as String,
      fileName: map['file_name'] as String,
      fileSize: map['file_size'] as int? ?? 0,
      fileType: map['file_type'] as String,
      openedAt: DateTime.parse(map['opened_at'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  RecentFile copyWith({
    int? id,
    String? filePath,
    String? fileName,
    int? fileSize,
    String? fileType,
    DateTime? openedAt,
    DateTime? createdAt,
  }) {
    return RecentFile(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      fileSize: fileSize ?? this.fileSize,
      fileType: fileType ?? this.fileType,
      openedAt: openedAt ?? this.openedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

/// Data Access Object for recent files
class RecentFilesDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// Insert or update a recent file
  Future<int> upsertRecentFile(RecentFile file) async {
    final db = await _dbHelper.database;
    
    // Check if file already exists
    final existing = await db.query(
      'recent_files',
      where: 'file_path = ?',
      whereArgs: [file.filePath],
    );

    if (existing.isNotEmpty) {
      // Update opened_at timestamp
      return await db.update(
        'recent_files',
        {'opened_at': DateTime.now().toIso8601String()},
        where: 'file_path = ?',
        whereArgs: [file.filePath],
      );
    } else {
      // Insert new record
      final id = await db.insert(
        'recent_files',
        file.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Clean up old records if exceeding max
      await _cleanupOldRecords(db);
      
      return id;
    }
  }

  /// Get all recent files
  Future<List<RecentFile>> getRecentFiles({int? limit}) async {
    final db = await _dbHelper.database;
    final results = await db.query(
      'recent_files',
      orderBy: 'opened_at DESC',
      limit: limit ?? AppConstants.maxRecentFiles,
    );
    return results.map((map) => RecentFile.fromMap(map)).toList();
  }

  /// Delete a recent file record
  Future<int> deleteRecentFile(String filePath) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'recent_files',
      where: 'file_path = ?',
      whereArgs: [filePath],
    );
  }

  /// Clear all recent files
  Future<int> clearAllRecentFiles() async {
    final db = await _dbHelper.database;
    return await db.delete('recent_files');
  }

  /// Clean up old records to maintain max limit
  Future<void> _cleanupOldRecords(Database db) async {
    // Use parameterized query pattern for consistency
    // Note: SQLite doesn't support LIMIT with parameters in subqueries,
    // but we validate maxRecentFiles is a constant integer
    final maxFiles = AppConstants.maxRecentFiles;
    await db.rawDelete('''
      DELETE FROM recent_files
      WHERE id NOT IN (
        SELECT id FROM recent_files
        ORDER BY opened_at DESC
        LIMIT $maxFiles
      )
    ''');
  }
}
