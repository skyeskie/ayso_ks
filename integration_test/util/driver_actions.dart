import 'package:flutter_driver_helper/flutter_driver_helper.dart';
import 'package:flutter_test/flutter_test.dart';

extension CommonTestActions on TestAction {
  static TestAction findText(String text) => TestAction(
        (tester) async {
          final finder = find.text(text);
          expect(finder, findsWidgets);
        },
        name: 'check for text "$text"',
      );

  static TestAction tapText(String text) => TestAction(
        (tester) async {
          await tester.tap(find.text(text).last);
        },
        name: 'tapping text "$text"',
      );

  static TestAction scrollForText(
    Finder scrollable,
    String text, {
    double amount = 300,
  }) =>
      TestAction(
        (tester) => tester.scrollUntilVisible(
          find.text(text),
          -amount,
          scrollable: scrollable,
        ),
      );
}
