import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart' as picker;
import '../../../../core/theme/theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/file_utils.dart';
import '../../../../core/database/recent_files_dao.dart';
import '../../../../shared/providers/recent_files_provider.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../viewer/presentation/screens/viewer_screen.dart';
import '../../domain/models/file_item.dart';

/// File browser screen
class FileBrowserScreen extends ConsumerStatefulWidget {
  const FileBrowserScreen({super.key});

  @override
  ConsumerState<FileBrowserScreen> createState() => _FileBrowserScreenState();
}

class _FileBrowserScreenState extends ConsumerState<FileBrowserScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final recentFilesAsync = ref.watch(recentFilesProvider);

    return CupertinoPageScaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.gray50,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: isDark ? AppColorsDark.surface : AppColors.white,
        border: null,
        middle: Text(
          '파일',
          style: AppTypography.h3.copyWith(
            color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
          ),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                // Recent files section
                recentFilesAsync.when(
                  data: (recentFiles) {
                    if (recentFiles.isNotEmpty) {
                      return SliverToBoxAdapter(
                        child: _buildRecentFilesSection(recentFiles, isDark),
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                  loading: () => const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.lg),
                      child: LoadingIndicator(),
                    ),
                  ),
                  error: (_, _) => const SliverToBoxAdapter(child: SizedBox.shrink()),
                ),

                // Open file section
                SliverToBoxAdapter(
                  child: _buildOpenFileSection(isDark),
                ),

                // Storage locations section
                SliverToBoxAdapter(
                  child: _buildStorageSection(isDark),
                ),

                // Bottom padding
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
              ],
            ),

            // Loading overlay
            if (_isLoading) const LoadingOverlay(message: '파일 열기 중...'),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentFilesSection(List<RecentFile> files, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          child: Text(
            '최근 파일',
            style: AppTypography.h3.copyWith(
              color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            itemCount: files.length > 10 ? 10 : files.length,
            itemBuilder: (context, index) {
              final file = files[index];
              return _buildRecentFileCard(file, isDark);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentFileCard(RecentFile file, bool isDark) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      onPressed: () => _openFile(file.filePath),
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: isDark ? AppColorsDark.surface : AppColors.white,
          borderRadius: AppRadius.cardRadius,
          border: isDark
              ? Border.all(color: AppColorsDark.border, width: 1)
              : null,
          boxShadow: isDark ? null : AppShadows.sm,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.doc_text_fill,
              color: file.fileType == 'hwp'
                  ? AppColors.primary
                  : AppColors.info,
              size: 32,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              file.fileName,
              style: AppTypography.caption.copyWith(
                color: isDark
                    ? AppColorsDark.textPrimary
                    : AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpenFileSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: _pickFile,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: isDark ? AppColorsDark.surface : AppColors.white,
            borderRadius: AppRadius.cardRadius,
            border: isDark
                ? Border.all(color: AppColorsDark.border, width: 1)
                : null,
            boxShadow: isDark ? null : AppShadows.sm,
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  CupertinoIcons.folder_open,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '파일 열기',
                      style: AppTypography.body.copyWith(
                        color: isDark
                            ? AppColorsDark.textPrimary
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'HWP, HWPX 파일 선택',
                      style: AppTypography.bodySmall.copyWith(
                        color: isDark
                            ? AppColorsDark.textSecondary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                CupertinoIcons.chevron_right,
                color: isDark ? AppColorsDark.textTertiary : AppColors.gray400,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStorageSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text(
              '저장소',
              style: AppTypography.h3.copyWith(
                color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColorsDark.surface : AppColors.white,
              borderRadius: AppRadius.cardRadius,
              border: isDark
                  ? Border.all(color: AppColorsDark.border, width: 1)
                  : null,
              boxShadow: isDark ? null : AppShadows.sm,
            ),
            child: Column(
              children: [
                _buildStorageItem(
                  icon: CupertinoIcons.cloud,
                  iconColor: AppColors.info,
                  title: 'iCloud Drive',
                  onTap: _pickFile,
                  isDark: isDark,
                ),
                Divider(
                  height: 1,
                  color: isDark ? AppColorsDark.divider : AppColors.divider,
                  indent: 64,
                ),
                _buildStorageItem(
                  icon: CupertinoIcons.device_phone_portrait,
                  iconColor: AppColors.gray500,
                  title: '내 iPhone',
                  onTap: _pickFile,
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 4,
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                title,
                style: AppTypography.body.copyWith(
                  color: isDark
                      ? AppColorsDark.textPrimary
                      : AppColors.textPrimary,
                ),
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              color: isDark ? AppColorsDark.textTertiary : AppColors.gray400,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    try {
      setState(() => _isLoading = true);

      final result = await picker.FilePicker.platform.pickFiles(
        type: picker.FileType.custom,
        allowedExtensions: AppConstants.supportedExtensions,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.path != null) {
          await _openFile(file.path!);
        }
      }
    } catch (e) {
      _showError('파일을 열 수 없습니다');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _openFile(String filePath) async {
    if (!FileUtils.isSupportedFile(filePath)) {
      _showError('지원하지 않는 파일 형식입니다');
      return;
    }

    // Add to recent files
    final fileItem = FileItem.fromPath(filePath);
    final recentFile = RecentFile(
      filePath: filePath,
      fileName: fileItem.name,
      fileSize: fileItem.size,
      fileType: fileItem.fileType.name,
      openedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );
    ref.read(recentFilesProvider.notifier).addRecentFile(recentFile);

    // Navigate to viewer
    if (mounted) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => ViewerScreen(filePath: filePath),
        ),
      );
    }
  }

  void _showError(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('오류'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
