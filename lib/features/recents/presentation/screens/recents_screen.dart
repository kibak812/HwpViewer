import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/recent_files_dao.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/file_utils.dart';
import '../../../../shared/providers/recent_files_provider.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../viewer/presentation/screens/viewer_screen.dart';

/// Recent files screen
class RecentsScreen extends ConsumerWidget {
  const RecentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final recentFilesAsync = ref.watch(recentFilesProvider);

    return CupertinoPageScaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.gray50,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: isDark ? AppColorsDark.surface : AppColors.white,
        border: null,
        middle: Text(
          '최근 항목',
          style: AppTypography.h3.copyWith(
            color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
          ),
        ),
        trailing: recentFilesAsync.maybeWhen(
          data: (files) => files.isNotEmpty
              ? CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => _showClearDialog(context, ref),
                  child: Text(
                    '모두 지우기',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                )
              : null,
          orElse: () => null,
        ),
      ),
      child: SafeArea(
        child: recentFilesAsync.when(
          data: (files) {
            if (files.isEmpty) {
              return const EmptyStateView(
                title: '최근 열어본 파일이 없습니다',
                message: '파일을 열면 여기에 표시됩니다',
                icon: CupertinoIcons.clock,
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return _buildRecentFileItem(context, ref, file, isDark);
              },
            );
          },
          loading: () => const LoadingIndicator(),
          error: (error, _) => ErrorView(
            title: '파일 목록을 불러올 수 없습니다',
            message: error.toString(),
            onRetry: () => ref.refresh(recentFilesProvider),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentFileItem(
    BuildContext context,
    WidgetRef ref,
    RecentFile file,
    bool isDark,
  ) {
    return Dismissible(
      key: Key(file.filePath),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.lg),
        color: AppColors.error,
        child: const Icon(
          CupertinoIcons.delete,
          color: AppColors.white,
        ),
      ),
      onDismissed: (_) {
        ref.read(recentFilesProvider.notifier).removeRecentFile(file.filePath);
      },
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => _openFile(context, file.filePath),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 4,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppColorsDark.surface : AppColors.white,
            border: Border(
              bottom: BorderSide(
                color: isDark ? AppColorsDark.divider : AppColors.divider,
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              // File icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: file.fileType == 'hwp'
                      ? (isDark
                          ? AppColors.primary.withValues(alpha: 0.2)
                          : AppColors.primaryLight)
                      : (isDark
                          ? AppColors.info.withValues(alpha: 0.2)
                          : AppColors.infoLight),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  CupertinoIcons.doc_text_fill,
                  color:
                      file.fileType == 'hwp' ? AppColors.primary : AppColors.info,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.sm + 4),
              // File info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FileUtils.truncateFileName(file.fileName),
                      style: AppTypography.body.copyWith(
                        color: isDark
                            ? AppColorsDark.textPrimary
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          file.fileType.toUpperCase(),
                          style: AppTypography.caption.copyWith(
                            color: isDark
                                ? AppColorsDark.textTertiary
                                : AppColors.textTertiary,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          AppDateUtils.formatDate(file.openedAt),
                          style: AppTypography.caption.copyWith(
                            color: isDark
                                ? AppColorsDark.textTertiary
                                : AppColors.textTertiary,
                          ),
                        ),
                      ],
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

  void _openFile(BuildContext context, String filePath) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ViewerScreen(filePath: filePath),
      ),
    );
  }

  void _showClearDialog(BuildContext context, WidgetRef ref) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('최근 항목 지우기'),
        content: const Text('모든 최근 항목을 삭제하시겠습니까?'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('취소'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('삭제'),
            onPressed: () {
              ref.read(recentFilesProvider.notifier).clearAllRecentFiles();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
