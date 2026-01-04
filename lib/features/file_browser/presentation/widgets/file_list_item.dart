import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/file_utils.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/models/file_item.dart';

/// File list item widget
class FileListItem extends StatelessWidget {
  final FileItem file;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const FileListItem({
    super.key,
    required this.file,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
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
                color: _getIconBackgroundColor(isDark),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(
                _getFileIcon(),
                color: _getIconColor(),
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
                    FileUtils.truncateFileName(file.name),
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
                        file.fileType.displayName,
                        style: AppTypography.caption.copyWith(
                          color: isDark
                              ? AppColorsDark.textTertiary
                              : AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        FileUtils.formatFileSize(file.size),
                        style: AppTypography.caption.copyWith(
                          color: isDark
                              ? AppColorsDark.textTertiary
                              : AppColors.textTertiary,
                        ),
                      ),
                      if (file.modifiedAt != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          AppDateUtils.formatDate(file.modifiedAt!),
                          style: AppTypography.caption.copyWith(
                            color: isDark
                                ? AppColorsDark.textTertiary
                                : AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            // Chevron
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

  Color _getIconBackgroundColor(bool isDark) {
    switch (file.fileType) {
      case FileType.hwp:
        return isDark
            ? AppColors.primary.withValues(alpha: 0.2)
            : AppColors.primaryLight;
      case FileType.hwpx:
        return isDark
            ? AppColors.info.withValues(alpha: 0.2)
            : AppColors.infoLight;
      case FileType.unknown:
        return isDark ? AppColorsDark.surfaceElevated : AppColors.gray100;
    }
  }

  Color _getIconColor() {
    switch (file.fileType) {
      case FileType.hwp:
        return AppColors.primary;
      case FileType.hwpx:
        return AppColors.info;
      case FileType.unknown:
        return AppColors.gray500;
    }
  }

  IconData _getFileIcon() {
    switch (file.fileType) {
      case FileType.hwp:
      case FileType.hwpx:
        return CupertinoIcons.doc_text_fill;
      case FileType.unknown:
        return CupertinoIcons.doc;
    }
  }
}
