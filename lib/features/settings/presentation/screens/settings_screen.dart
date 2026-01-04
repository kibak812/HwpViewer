import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/providers/theme_provider.dart';

/// Settings screen
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = '${info.version} (${info.buildNumber})';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeMode = ref.watch(themeProvider);

    return CupertinoPageScaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.gray50,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: isDark ? AppColorsDark.surface : AppColors.white,
        border: null,
        middle: Text(
          '설정',
          style: AppTypography.h3.copyWith(
            color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          children: [
            // Appearance section
            _buildSectionHeader('화면', isDark),
            _buildSettingsGroup(
              isDark: isDark,
              children: [
                _buildThemeSelector(isDark, themeMode),
              ],
            ),

            const SizedBox(height: AppSpacing.lg),

            // About section
            _buildSectionHeader('정보', isDark),
            _buildSettingsGroup(
              isDark: isDark,
              children: [
                _buildSettingsItem(
                  icon: CupertinoIcons.star,
                  iconColor: AppColors.warning,
                  title: '앱 평가하기',
                  onTap: _rateApp,
                  isDark: isDark,
                ),
                _buildDivider(isDark),
                _buildSettingsItem(
                  icon: CupertinoIcons.mail,
                  iconColor: AppColors.info,
                  title: '문의하기',
                  onTap: _sendFeedback,
                  isDark: isDark,
                ),
                _buildDivider(isDark),
                _buildSettingsItem(
                  icon: CupertinoIcons.doc_text,
                  iconColor: AppColors.gray500,
                  title: '오픈소스 라이선스',
                  onTap: () => _showLicenses(context),
                  isDark: isDark,
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.lg),

            // Version info
            Center(
              child: Column(
                children: [
                  Text(
                    AppConstants.appNameKorean,
                    style: AppTypography.body.copyWith(
                      color: isDark
                          ? AppColorsDark.textSecondary
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '버전 $_appVersion',
                    style: AppTypography.caption.copyWith(
                      color: isDark
                          ? AppColorsDark.textTertiary
                          : AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Text(
        title,
        style: AppTypography.caption.copyWith(
          color: isDark ? AppColorsDark.textTertiary : AppColors.textTertiary,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup({
    required bool isDark,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColors.white,
        borderRadius: AppRadius.cardRadius,
        border: isDark
            ? Border.all(color: AppColorsDark.border, width: 1)
            : null,
        boxShadow: isDark ? null : AppShadows.sm,
      ),
      child: Column(children: children),
    );
  }

  Widget _buildThemeSelector(bool isDark, AppThemeMode currentMode) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _showThemePicker(isDark, currentMode),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 4,
        ),
        child: Row(
          children: [
            Icon(
              currentMode.icon,
              color: AppColors.primary,
              size: 24,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '테마',
                    style: AppTypography.body.copyWith(
                      color: isDark
                          ? AppColorsDark.textPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    currentMode.displayName,
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
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    required bool isDark,
    Widget? trailing,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.body.copyWith(
                      color: isDark
                          ? AppColorsDark.textPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTypography.bodySmall.copyWith(
                        color: isDark
                            ? AppColorsDark.textSecondary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing ??
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

  Widget _buildDivider(bool isDark) {
    return Container(
      height: 0.5,
      margin: const EdgeInsets.only(left: 56),
      color: isDark ? AppColorsDark.divider : AppColors.divider,
    );
  }

  void _showThemePicker(bool isDark, AppThemeMode currentMode) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('테마 선택'),
        actions: AppThemeMode.values.map((mode) {
          return CupertinoActionSheetAction(
            onPressed: () {
              ref.read(themeProvider.notifier).setThemeMode(mode);
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(mode.icon, size: 20),
                const SizedBox(width: 8),
                Text(mode.displayName),
                if (mode == currentMode) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    CupertinoIcons.checkmark,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ],
              ],
            ),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
      ),
    );
  }

  Future<void> _rateApp() async {
    final url = Uri.parse(AppConstants.appStoreUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _sendFeedback() async {
    final url = Uri.parse('mailto:${AppConstants.supportEmail}?subject=HWP Viewer 피드백');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _showLicenses(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: AppConstants.appNameKorean,
      applicationVersion: _appVersion,
    );
  }
}
