import 'package:ayso_ks/widgets/large_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('display and callback', (tester) async {
    var presses = 0;
    final widget = LargeIconButton(
      icon: Icons.terrain,
      label: Text('Test Label'),
      action: () => presses++,
    );
    await tester.pumpWidget(MaterialApp(home: widget));

    expect(find.text('Test Label'), findsOneWidget);
    expect(find.byIcon(Icons.terrain), findsOneWidget);

    await tester.tap(find.text('Test Label'));
    expect(presses, 1);
  });
}
