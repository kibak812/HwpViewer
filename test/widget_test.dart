import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hwp_viewer/app.dart';

void main() {
  testWidgets('App should launch without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: HwpViewerApp(),
      ),
    );

    // Verify that the app launches and shows the file browser
    expect(find.text('파일'), findsWidgets);
  });
}
