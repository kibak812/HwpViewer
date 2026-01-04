import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/recent_files_dao.dart';
import '../../core/errors/app_exceptions.dart';

/// Recent files state notifier
class RecentFilesNotifier extends StateNotifier<AsyncValue<List<RecentFile>>> {
  final RecentFilesDao _dao = RecentFilesDao();

  RecentFilesNotifier() : super(const AsyncValue.loading()) {
    loadRecentFiles();
  }

  /// Load recent files from database
  Future<void> loadRecentFiles() async {
    state = const AsyncValue.loading();
    try {
      final files = await _dao.getRecentFiles();
      state = AsyncValue.data(files);
    } catch (e, st) {
      AppLogger.error('Failed to load recent files', error: e, stackTrace: st, name: 'RecentFilesNotifier');
      state = AsyncValue.error(e, st);
    }
  }

  /// Add or update a recent file
  Future<void> addRecentFile(RecentFile file) async {
    try {
      await _dao.upsertRecentFile(file);
      await loadRecentFiles();
    } catch (e, st) {
      AppLogger.error('Failed to add recent file', error: e, stackTrace: st, name: 'RecentFilesNotifier');
    }
  }

  /// Remove a recent file
  Future<void> removeRecentFile(String filePath) async {
    try {
      await _dao.deleteRecentFile(filePath);
      await loadRecentFiles();
    } catch (e, st) {
      AppLogger.error('Failed to remove recent file', error: e, stackTrace: st, name: 'RecentFilesNotifier');
    }
  }

  /// Clear all recent files
  Future<void> clearAllRecentFiles() async {
    try {
      await _dao.clearAllRecentFiles();
      state = const AsyncValue.data([]);
    } catch (e, st) {
      AppLogger.error('Failed to clear recent files', error: e, stackTrace: st, name: 'RecentFilesNotifier');
    }
  }
}

/// Recent files provider
final recentFilesProvider =
    StateNotifierProvider<RecentFilesNotifier, AsyncValue<List<RecentFile>>>((ref) {
  return RecentFilesNotifier();
});
