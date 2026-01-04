import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Custom loading indicator with iOS style
class LoadingIndicator extends StatelessWidget {
  final String? message;
  final double size;
  final Color? color;

  const LoadingIndicator({
    super.key,
    this.message,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final indicatorColor = color ?? (isDark ? AppColors.white : AppColors.primary);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoActivityIndicator(
            radius: size / 2,
            color: indicatorColor,
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColorsDark.textSecondary
                        : AppColors.textSecondary,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Full screen loading overlay
class LoadingOverlay extends StatelessWidget {
  final String? message;

  const LoadingOverlay({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: LoadingIndicator(
        message: message,
        size: 32,
        color: AppColors.white,
      ),
    );
  }
}

/// Skeleton loading widget for list items
class SkeletonLoader extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonLoader({
    super.key,
    this.width = double.infinity,
    this.height = 20,
    this.borderRadius = 4,
  });

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(-1 + _animation.value, 0),
              end: Alignment(_animation.value, 0),
              colors: isDark
                  ? [
                      AppColorsDark.surface,
                      AppColorsDark.surfaceElevated,
                      AppColorsDark.surface,
                    ]
                  : [
                      AppColors.gray100,
                      AppColors.gray50,
                      AppColors.gray100,
                    ],
            ),
          ),
        );
      },
    );
  }
}
