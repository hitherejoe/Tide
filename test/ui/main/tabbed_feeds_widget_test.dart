import 'package:flutter/material.dart';
import 'package:tidal/ui/main/tabbed_feeds_widget.dart' as tabbed_feeds_widget;
import 'package:tidal/ui/main/main.dart' as main_widget;
import 'package:flutter_test/flutter_test.dart';

void main() {
  final TestWidgetsFlutterBinding binding =
  TestWidgetsFlutterBinding.ensureInitialized();
  if (binding is LiveTestWidgetsFlutterBinding)
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets("tab bar shows latest photos tab", (WidgetTester tester) async {
    main_widget.main();
    await tester.pump();

    expect(findTab(tabbed_feeds_widget.choices[0].title), findsOneWidget);
  });

  testWidgets("tab bar shows curated photos tab", (WidgetTester tester) async {
    main_widget.main();
    await tester.pump();

      expect(findTab(tabbed_feeds_widget.choices[1].title), findsOneWidget);
  });
}


Finder findTab(String label) {
  return find.descendant(of: find.byType(Tab), matching: find.text(label));
}