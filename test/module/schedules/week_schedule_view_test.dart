import 'package:ayso_ks/module/schedules/week_schedule_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/test_it.dart';

void main() {
  tearDown(TestIt.clean);

  testWidgets('display default', (tester) async {
    TestIt.registerGamesDAO();
    TestIt.registerSettings();
    TestIt.registerWeekCache();
    await tester.pumpWidget(MaterialApp(home: WeekScheduleView()));
    expect(find.text('Loading...'), findsOneWidget);
    expect(find.text('Region  Schedule'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Loading...'), findsNothing);

    expect(find.text('Region 49 Schedule'), findsOneWidget);
    expect(find.text('Week #2'), findsOneWidget);
  });

  testWidgets('week bar navigation', (tester) async {
    TestIt.registerGamesDAO();
    TestIt.registerSettings();
    TestIt.registerWeekCache();
    final nav = TestIt.stubNavigation();
    await tester.pumpWidget(MaterialApp(home: WeekScheduleView()));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.tap(find.byIcon(Icons.arrow_forward));
    expect(nav.attempts, hasLength(2));
    expect(nav.attempts.first.name, '/schedules/week');
    expect(nav.attempts.first.params['week'], 1);
    expect(nav.attempts.last.name, '/schedules/week');
    expect(nav.attempts.last.params['week'], 3);
  });
}
