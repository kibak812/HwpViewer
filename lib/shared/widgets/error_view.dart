import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

/// Error view widget
class ErrorView extends StatelessWidget {
  final String title;
  final String? message;
  final String? retryButtonText;
  final VoidCallback? onRetry;
  final IconData? icon;

  const ErrorView({
    super.key,
    required this.title,
    this.message,
    this.retryButtonText,
    this.onRetry,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? CupertinoIcons.exclamationmark_circle,
              size: 64,
              color: isDark ? AppColorsDark.textTertiary : AppColors.textTertiary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: AppTypography.h3.copyWith(
                color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                style: AppTypography.body.copyWith(
                  color: isDark
                      ? AppColorsDark.textSecondary
                      : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              CupertinoButton(
                onPressed: onRetry,
                child: Text(retryButtonText ?? '다시 시도'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Empty state view
class EmptyStateView extends StatelessWidget {
  final String title;
  final String? message;
  final IconData? icon;
  final Widget? action;

  const EmptyStateView({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? CupertinoIcons.doc_text,
              size: 80,
              color: isDark ? AppColorsDark.textTertiary : AppColors.gray300,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: AppTypography.h3.copyWith(
                color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                style: AppTypography.body.copyWith(
                  color: isDark
                      ? AppColorsDark.textSecondary
                      : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: AppSpacing.lg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
