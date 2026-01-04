import 'package:intl/intl.dart';

/// Date utility functions
class AppDateUtils {
  AppDateUtils._();

  /// Format date for display
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return '방금 전';
        }
        return '${difference.inMinutes}분 전';
      }
      return '${difference.inHours}시간 전';
    } else if (difference.inDays == 1) {
      return '어제';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else if (date.year == now.year) {
      return DateFormat('M월 d일').format(date);
    } else {
      return DateFormat('yyyy년 M월 d일').format(date);
    }
  }

  /// Format date with time
  static String formatDateTime(DateTime date) {
    return DateFormat('yyyy년 M월 d일 HH:mm').format(date);
  }

  /// Format short date
  static String formatShortDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year) {
      return DateFormat('M/d').format(date);
    }
    return DateFormat('yy/M/d').format(date);
  }
}
