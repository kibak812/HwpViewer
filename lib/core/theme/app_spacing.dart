/// App spacing based on 8pt grid system from modern-app-design-principles.md
class AppSpacing {
  AppSpacing._();

  // Base spacing values (8pt grid)
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;

  // Semantic spacing
  static const double componentGap = md; // 16
  static const double sectionGap = xl; // 32
  static const double screenPadding = md; // 16
  static const double cardPadding = md; // 16
  static const double listItemGap = sm; // 8

  // Touch targets
  static const double minTouchTarget = 44;
  static const double preferredTouchTarget = 48;

  // Screen margins by device width
  static double screenMargin(double screenWidth) {
    if (screenWidth < 360) return 12;
    if (screenWidth < 428) return 16;
    if (screenWidth < 600) return 20;
    if (screenWidth < 905) return 24;
    if (screenWidth < 1240) return 32;
    return 40;
  }
}
