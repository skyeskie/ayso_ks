import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_driver_helper/flutter_driver_helper.dart';

extension CommonTestActions on TestAction {
  static TestAction findText(FlutterDriver driver, String text) => TestAction(
        () async {
          final finder = find.text(text);
          await driver.waitFor(finder);
        },
        name: 'check for text "$text"',
      );

  static TestAction tapText(FlutterDriver driver, String text) => TestAction(
        () async {
          await driver.tap(find.text(text));
        },
        name: 'tapping text "$text"',
      );

  static TestAction scrollForText(
    FlutterDriver driver,
    SerializableFinder scrollable,
    String text, {
    double amount = 300,
  }) =>
      TestAction(
        () => driver.scrollUntilVisible(
          scrollable,
          find.text(text),
          dyScroll: -amount,
        ),
      );
}
