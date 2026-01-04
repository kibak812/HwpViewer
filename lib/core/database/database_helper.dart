import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../constants/app_constants.dart';

/// Database helper for managing SQLite database
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  /// Get database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize database
  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, AppConstants.databaseName);

    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Create tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE recent_files (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        file_path TEXT NOT NULL UNIQUE,
        file_name TEXT NOT NULL,
        file_size INTEGER DEFAULT 0,
        file_type TEXT NOT NULL,
        opened_at TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_recent_files_opened_at ON recent_files(opened_at DESC)
    ''');

    await db.execute('''
      CREATE TABLE settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');
  }

  /// Upgrade database
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle future migrations here
  }

  /// Close database
  Future<void> close() async {
    // Fix race condition: set null before closing to prevent reinitialization
    final db = _database;
    if (db != null) {
      _database = null;
      await db.close();
    }
  }
}
