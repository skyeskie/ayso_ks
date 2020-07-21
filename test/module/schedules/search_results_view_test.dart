import 'package:ayso_ks/module/schedules/search_results_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/test_it.dart';

void main() {
  tearDown(TestIt.clean);

  testWidgets('display only week filter', (tester) async {
    TestIt.registerWeekCache();
    TestIt.registerGamesDAO();
    await tester.pumpWidget(MaterialApp(home: SearchResultsView(week: 2)));
    expect(find.text('Week #2'), findsOneWidget);
    expect(find.text('Loading...'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Loading...'), findsNothing);

    expect(find.text('Filters'), findsNothing);
  });

  testWidgets('display all filters', (tester) async {
    TestIt.registerWeekCache();
    TestIt.registerGamesDAO();
    await tester.pumpWidget(MaterialApp(
      home: SearchResultsView(
        week: 2,
        regionNum: 49,
        gender: 'Boys',
        ageGroup: 'U10',
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Filters'), findsOneWidget);
    expect(find.text('Region 49'), findsOneWidget);
    expect(find.text('Age U10'), findsOneWidget);
    expect(find.text('Boys'), findsOneWidget);
  });

  testWidgets('navigation', (tester) async {
    TestIt.registerWeekCache();
    TestIt.registerGamesDAO();
    final nav = TestIt.stubNavigation();
    await tester.pumpWidget(MaterialApp(
      home: SearchResultsView(
        week: 2,
        regionNum: 208,
        gender: 'Boys',
        ageGroup: 'U10',
      ),
    ));

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.tap(find.byIcon(Icons.arrow_forward));
    expect(nav.attempts, hasLength(2));
    expect(nav.attempts.first.name, '/schedules/filtered');
    expect(nav.attempts.first.params['week'], 1);
    expect(nav.attempts.first.params['regionNum'], 208);
    expect(nav.attempts.first.params['gender'], 'Boys');
    expect(nav.attempts.first.params['age'], 'U10');
    expect(nav.attempts.last.name, '/schedules/filtered');
    expect(nav.attempts.last.params['week'], 3);
    expect(nav.attempts.last.params['regionNum'], 208);
    expect(nav.attempts.last.params['gender'], 'Boys');
    expect(nav.attempts.last.params['age'], 'U10');
  });
}
