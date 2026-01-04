import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Service to handle files opened from external apps
class FileHandlerService {
  static const _channel = MethodChannel('com.hwpviewer/file_handler');
  
  Function(String filePath)? _onFileOpened;
  
  FileHandlerService() {
    _setupMethodCallHandler();
  }
  
  void _setupMethodCallHandler() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'fileOpened') {
        final filePath = call.arguments as String?;
        if (filePath != null && _onFileOpened != null) {
          _onFileOpened!(filePath);
        }
      }
    });
  }
  
  /// Set callback for when a file is opened from external app
  void setOnFileOpened(Function(String filePath) callback) {
    _onFileOpened = callback;
  }
  
  /// Check if there's a pending file from app launch
  Future<String?> getPendingFile() async {
    try {
      final result = await _channel.invokeMethod<String>('getPendingFile');
      return result;
    } on PlatformException {
      return null;
    }
  }
  
  /// Clear the callback
  void dispose() {
    _onFileOpened = null;
  }
}

/// Provider for file handler service
final fileHandlerServiceProvider = Provider<FileHandlerService>((ref) {
  final service = FileHandlerService();
  ref.onDispose(() => service.dispose());
  return service;
});
