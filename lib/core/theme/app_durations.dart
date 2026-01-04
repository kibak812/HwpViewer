/// App animation durations based on modern-app-design-principles.md
class AppDurations {
  AppDurations._();

  // Base durations
  static const Duration fast = Duration(milliseconds: 100);
  static const Duration normal = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 300);
  static const Duration slower = Duration(milliseconds: 400);

  // Semantic durations
  static const Duration feedback = fast; // 100ms
  static const Duration transition = slow; // 300ms
  static const Duration pageTransition = slower; // 400ms
  static const Duration staggerDelay = Duration(milliseconds: 30);
}
