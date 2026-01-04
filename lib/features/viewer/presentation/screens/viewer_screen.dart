import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/file_utils.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../domain/services/hwp_parser_service.dart';

/// Document viewer screen
class ViewerScreen extends StatefulWidget {
  final String filePath;

  const ViewerScreen({
    super.key,
    required this.filePath,
  });

  @override
  State<ViewerScreen> createState() => _ViewerScreenState();
}

class _ViewerScreenState extends State<ViewerScreen> {
  late final HwpParserService _parserService;
  InAppWebViewController? _webViewController;

  bool _isLoading = true;
  String? _errorMessage;
  String? _htmlContent;
  String _fileName = '';

  /// Escape string for safe JavaScript interpolation
  String _escapeForJavaScript(String input) {
    return input
        .replaceAll('\\', '\\\\')
        .replaceAll("'", "\\'")
        .replaceAll('"', '\\"')
        .replaceAll('\n', '\\n')
        .replaceAll('\r', '\\r')
        .replaceAll('\t', '\\t')
        .replaceAll('\$', '\\\$');
  }

  /// Escape special regex characters
  String _escapeRegExp(String input) {
    return input.replaceAllMapped(
      RegExp(r'[.*+?^${}()|[\]\\]'),
      (match) => '\\${match.group(0)}',
    );
  }

  // Search
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  int _searchResultCount = 0;
  int _currentSearchIndex = 0;

  @override
  void initState() {
    super.initState();
    _parserService = HwpParserService();
    _fileName = FileUtils.getFileNameWithExtension(widget.filePath);
    _loadDocument();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadDocument() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final file = File(widget.filePath);
      if (!await file.exists()) {
        throw Exception('파일을 찾을 수 없습니다');
      }

      final bytes = await file.readAsBytes();
      final html = await _parserService.parseToHtml(
        bytes,
        FileUtils.getExtension(widget.filePath),
      );

      setState(() {
        _htmlContent = html;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoPageScaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.white,
      navigationBar: _buildNavigationBar(isDark),
      child: SafeArea(
        child: Column(
          children: [
            // Search bar
            if (_isSearching) _buildSearchBar(isDark),

            // Content
            Expanded(
              child: _buildContent(isDark),
            ),
          ],
        ),
      ),
    );
  }

  CupertinoNavigationBar _buildNavigationBar(bool isDark) {
    return CupertinoNavigationBar(
      backgroundColor: isDark ? AppColorsDark.surface : AppColors.white,
      border: Border(
        bottom: BorderSide(
          color: isDark ? AppColorsDark.divider : AppColors.divider,
          width: 0.5,
        ),
      ),
      middle: Text(
        FileUtils.truncateFileName(_fileName, maxLength: 25),
        style: AppTypography.body.copyWith(
          color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() => _isSearching = !_isSearching);
              if (!_isSearching) {
                _clearSearch();
              }
            },
            child: Icon(
              _isSearching
                  ? CupertinoIcons.xmark
                  : CupertinoIcons.search,
              color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              size: 22,
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _shareDocument,
            child: Icon(
              CupertinoIcons.share,
              color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColors.gray50,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColorsDark.divider : AppColors.divider,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CupertinoSearchTextField(
              controller: _searchController,
              placeholder: '문서에서 검색',
              onChanged: _onSearchChanged,
              style: AppTypography.body.copyWith(
                color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              ),
            ),
          ),
          if (_searchResultCount > 0) ...[
            const SizedBox(width: AppSpacing.sm),
            Text(
              '$_currentSearchIndex / $_searchResultCount',
              style: AppTypography.caption.copyWith(
                color: isDark
                    ? AppColorsDark.textSecondary
                    : AppColors.textSecondary,
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(4),
              onPressed: _previousSearchResult,
              child: Icon(
                CupertinoIcons.chevron_up,
                size: 20,
                color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(4),
              onPressed: _nextSearchResult,
              child: Icon(
                CupertinoIcons.chevron_down,
                size: 20,
                color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContent(bool isDark) {
    if (_isLoading) {
      return const LoadingIndicator(message: '문서 로딩 중...');
    }

    if (_errorMessage != null) {
      return ErrorView(
        title: '문서를 열 수 없습니다',
        message: _errorMessage,
        retryButtonText: '다시 시도',
        onRetry: _loadDocument,
      );
    }

    if (_htmlContent == null) {
      return const ErrorView(
        title: '문서 내용이 없습니다',
        icon: CupertinoIcons.doc,
      );
    }

    return InAppWebView(
      initialData: InAppWebViewInitialData(
        data: _wrapHtmlWithStyles(_htmlContent!, isDark),
        mimeType: 'text/html',
        encoding: 'utf-8',
      ),
      initialSettings: InAppWebViewSettings(
        transparentBackground: true,
        javaScriptEnabled: true,
        supportZoom: true,
        builtInZoomControls: true,
        displayZoomControls: false,
        useWideViewPort: true,
        loadWithOverviewMode: true,
        // Security: Disable file and content access to prevent local file access attacks
        allowFileAccess: false,
        allowContentAccess: false,
        // Additional security settings
        allowUniversalAccessFromFileURLs: false,
        allowFileAccessFromFileURLs: false,
      ),
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      onLoadStop: (controller, url) {
        // WebView loaded
      },
    );
  }

  String _wrapHtmlWithStyles(String content, bool isDark) {
    final backgroundColor = isDark ? '#1a1a1a' : '#ffffff';
    final textColor = isDark ? '#e5e5e5' : '#18181b';

    return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=4.0, user-scalable=yes">
  <meta http-equiv="Content-Security-Policy" content="default-src 'none'; style-src 'unsafe-inline'; img-src data: blob:; script-src 'unsafe-inline';">
  <style>
    * {
      box-sizing: border-box;
    }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif;
      font-size: 16px;
      line-height: 1.6;
      color: $textColor;
      background-color: $backgroundColor;
      padding: 16px;
      margin: 0;
      word-wrap: break-word;
      overflow-wrap: break-word;
    }
    p {
      margin: 0 0 1em 0;
    }
    table {
      border-collapse: collapse;
      width: 100%;
      margin: 1em 0;
    }
    th, td {
      border: 1px solid ${isDark ? '#3f3f46' : '#e4e4e7'};
      padding: 8px;
      text-align: left;
    }
    th {
      background-color: ${isDark ? '#27272a' : '#f4f4f5'};
    }
    img {
      max-width: 100%;
      height: auto;
    }
    .highlight {
      background-color: ${isDark ? '#854d0e' : '#fef08a'};
      color: ${isDark ? '#fef08a' : '#854d0e'};
    }
    .highlight-current {
      background-color: ${isDark ? '#c2410c' : '#fdba74'};
      color: ${isDark ? '#fff' : '#000'};
    }
  </style>
</head>
<body>
  $content
</body>
</html>
''';
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      _clearSearch();
      return;
    }
    _performSearch(query);
  }

  Future<void> _performSearch(String query) async {
    if (_webViewController == null) return;

    // Escape query for safe JavaScript and RegExp usage
    final escapedQuery = _escapeForJavaScript(_escapeRegExp(query));

    await _webViewController!.evaluateJavascript(source: '''
      (function() {
        // Clear previous highlights
        document.querySelectorAll('.highlight, .highlight-current').forEach(el => {
          el.outerHTML = el.innerHTML;
        });

        if ('$escapedQuery' === '') return 0;

        const regex = new RegExp('$escapedQuery', 'gi');
        const walker = document.createTreeWalker(
          document.body,
          NodeFilter.SHOW_TEXT,
          null,
          false
        );

        let count = 0;
        const nodesToReplace = [];

        while (walker.nextNode()) {
          const node = walker.currentNode;
          if (regex.test(node.nodeValue)) {
            nodesToReplace.push(node);
          }
        }

        nodesToReplace.forEach(node => {
          const span = document.createElement('span');
          span.innerHTML = node.nodeValue.replace(regex, '<span class="highlight">\$&</span>');
          node.parentNode.replaceChild(span, node);
        });

        const highlights = document.querySelectorAll('.highlight');
        count = highlights.length;
        if (count > 0) {
          highlights[0].classList.add('highlight-current');
          highlights[0].scrollIntoView({ behavior: 'smooth', block: 'center' });
        }

        return count;
      })()
    ''').then((result) {
      if (!mounted) return;
      setState(() {
        _searchResultCount = int.tryParse(result?.toString() ?? '0') ?? 0;
        _currentSearchIndex = _searchResultCount > 0 ? 1 : 0;
      });
    });
  }

  Future<void> _nextSearchResult() async {
    if (_webViewController == null || _searchResultCount == 0) return;

    final nextIndex = _currentSearchIndex >= _searchResultCount ? 1 : _currentSearchIndex + 1;

    await _webViewController!.evaluateJavascript(source: '''
      (function() {
        const highlights = document.querySelectorAll('.highlight');
        highlights.forEach(el => el.classList.remove('highlight-current'));
        if (highlights.length >= $nextIndex) {
          highlights[${nextIndex - 1}].classList.add('highlight-current');
          highlights[${nextIndex - 1}].scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
      })()
    ''');

    setState(() {
      _currentSearchIndex = nextIndex;
    });
  }

  Future<void> _previousSearchResult() async {
    if (_webViewController == null || _searchResultCount == 0) return;

    final prevIndex = _currentSearchIndex <= 1 ? _searchResultCount : _currentSearchIndex - 1;

    await _webViewController!.evaluateJavascript(source: '''
      (function() {
        const highlights = document.querySelectorAll('.highlight');
        highlights.forEach(el => el.classList.remove('highlight-current'));
        if (highlights.length >= $prevIndex) {
          highlights[${prevIndex - 1}].classList.add('highlight-current');
          highlights[${prevIndex - 1}].scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
      })()
    ''');

    setState(() {
      _currentSearchIndex = prevIndex;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchResultCount = 0;
      _currentSearchIndex = 0;
    });

    _webViewController?.evaluateJavascript(source: '''
      (function() {
        document.querySelectorAll('.highlight, .highlight-current').forEach(el => {
          el.outerHTML = el.innerHTML;
        });
      })()
    ''');
  }

  Future<void> _shareDocument() async {
    try {
      await Share.shareXFiles(
        [XFile(widget.filePath)],
        subject: _fileName,
      );
    } catch (e) {
      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('공유 실패'),
            content: const Text('파일을 공유할 수 없습니다'),
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
  }
}
