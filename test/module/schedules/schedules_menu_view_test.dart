import 'package:ayso_ks/module/schedules/schedules_menu_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/test_it.dart';

void main() {
  const buttonText = [
    'This Week',
    'Find Team',
    'Advanced Search',
    'Directions',
    'Field Map',
  ];

  testWidgets('view', (tester) async {
    await tester.pumpWidget(MaterialApp(home: SchedulesMenuView(49)));
    await tester.pumpAndSettle();

    expect(find.text('Schedules'), findsOneWidget);
    expect(find.text('Region 49'), findsNWidgets(2));

    for (final text in buttonText) {
      expect(find.text(text), findsOneWidget);
    }
  });

  testWidgets('navigation', (tester) async {
    final nav = TestIt.stubNavigation();
    await tester.pumpWidget(MaterialApp(home: SchedulesMenuView(49)));

    for (final text in buttonText) {
      await tester.tap(find.text(text));
    }

    expect(nav.attempts, hasLength(buttonText.length));
    expect(nav.attempts[0].name, '/schedules/week_current');
    expect(nav.attempts[1].name, '/search/teams');
    expect(nav.attempts[2].name, '/search');
    expect(nav.attempts[3].name, '/region/map');
    expect(nav.attempts[3].params['regionNum'], 49);
    expect(nav.attempts[4].name, '/region/field');
    expect(nav.attempts[4].params['regionNum'], 49);
  });
}
