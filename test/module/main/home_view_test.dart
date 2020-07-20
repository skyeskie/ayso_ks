import 'package:ayso_ks/module/main/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/test_it.dart';

void main() {
  const buttonText = {
    'Schedules': '/schedules',
    'Region Info': '/region',
    'My Teams': '/schedules/favorites',
    'Cancellations': '/cancellations',
    'Settings': '/settings',
  };

  tearDown(TestIt.clean);

  testWidgets('display', (tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeView()));
    for (final text in buttonText.keys) {
      expect(find.text(text), findsOneWidget);
    }
  });

  testWidgets('navigation', (tester) async {
    TestIt.registerSettings();
    final nav = TestIt.stubNavigation();
    await tester.pumpWidget(MaterialApp(home: HomeView()));

    for (final text in buttonText.keys) {
      await tester.tap(find.text(text));
    }
    expect(nav.attempts.length, buttonText.length);
    final navTargets = buttonText.values.toList();
    for (var i = 1; i < buttonText.length; i++) {
      expect(nav.attempts[i].name, navTargets[i]);
    }
  });
}
