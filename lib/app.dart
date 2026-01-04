import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/theme.dart';
import 'shared/providers/theme_provider.dart';
import 'shared/services/file_handler_service.dart';
import 'features/file_browser/presentation/screens/file_browser_screen.dart';
import 'features/recents/presentation/screens/recents_screen.dart';
import 'features/settings/presentation/screens/settings_screen.dart';
import 'features/viewer/presentation/screens/viewer_screen.dart';

/// Global navigator key for navigation from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Main app widget
class HwpViewerApp extends ConsumerStatefulWidget {
  const HwpViewerApp({super.key});

  @override
  ConsumerState<HwpViewerApp> createState() => _HwpViewerAppState();
}

class _HwpViewerAppState extends ConsumerState<HwpViewerApp> {
  @override
  void initState() {
    super.initState();
    _initFileHandler();
  }

  Future<void> _initFileHandler() async {
    final fileHandler = ref.read(fileHandlerServiceProvider);

    // Set callback for files opened while app is running
    fileHandler.setOnFileOpened(_handleFileOpened);

    // Check for pending file from app launch (delayed to ensure navigation is ready)
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final pendingFile = await fileHandler.getPendingFile();
      // Check if widget is still mounted before handling file
      if (!mounted) return;
      if (pendingFile != null) {
        _handleFileOpened(pendingFile);
      }
    });
  }

  void _handleFileOpened(String filePath) {
    // Navigate to viewer screen
    navigatorKey.currentState?.push(
      CupertinoPageRoute(
        builder: (context) => ViewerScreen(filePath: filePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch state changes for rebuilding
    ref.watch(themeProvider);
    // Get actual ThemeMode from notifier
    final themeMode = ref.read(themeProvider.notifier).themeMode;

    return MaterialApp(
      title: 'HWP Viewer',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: const MainNavigationScreen(),
    );
  }
}

/// Main navigation screen with bottom tab bar
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    FileBrowserScreen(),
    RecentsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: isDark ? AppColorsDark.surface : AppColors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColorsDark.divider : AppColors.divider,
            width: 0.5,
          ),
        ),
        activeColor: AppColors.primary,
        inactiveColor: isDark ? AppColors.gray500 : AppColors.gray400,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.folder),
            activeIcon: Icon(CupertinoIcons.folder_fill),
            label: '파일',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock),
            activeIcon: Icon(CupertinoIcons.clock_fill),
            label: '최근',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            activeIcon: Icon(CupertinoIcons.settings_solid),
            label: '설정',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => _screens[index],
        );
      },
    );
  }
}
