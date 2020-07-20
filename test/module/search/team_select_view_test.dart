import 'package:ayso_ks/module/search/team_select_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/test_it.dart';

void main() {
  setUp(TestIt.registerTeamsDAO);
  tearDown(TestIt.clean);

  testWidgets('labels present', (tester) async {
    await tester.pumpWidget(MaterialApp(home: TeamSelectView()));
    expect(find.text('Region'), findsOneWidget);
    expect(find.text('Age Group'), findsOneWidget);
    expect(find.text('Gender'), findsOneWidget);
    expect(find.text('Teams'), findsOneWidget);
  });

  testWidgets('team filtering', (tester) async {
    await tester.pumpWidget(MaterialApp(home: TeamSelectView()));
    await tester.pumpAndSettle();
    expect(find.text('A'), findsOneWidget); //49-U10B
    expect(find.text('G'), findsOneWidget); //208-U12G

    //Region
    await tester.tap(find.text('49'));
    await tester.pump();
    expect(find.text('A'), findsOneWidget);
    expect(find.text('G'), findsNothing);
    await tester.tap(find.text('208'));
    await tester.pump();
    expect(find.text('A'), findsNothing);
    expect(find.text('G'), findsOneWidget);
    await tester.tap(find.text('208'));
    await tester.pump();
    expect(find.text('A'), findsOneWidget);
    expect(find.text('G'), findsOneWidget);

    //Age Group
    await tester.tap(find.text('U10'));
    await tester.pump();
    expect(find.text('A'), findsOneWidget);
    expect(find.text('G'), findsNothing);
    await tester.tap(find.text('U12'));
    await tester.pump();
    expect(find.text('A'), findsNothing);
    expect(find.text('G'), findsOneWidget);
    await tester.tap(find.text('U12'));
    await tester.pump();
    expect(find.text('A'), findsOneWidget);
    expect(find.text('G'), findsOneWidget);

    //Gender
    await tester.tap(find.text('Boys'));
    await tester.pump();
    expect(find.text('A'), findsOneWidget);
    expect(find.text('G'), findsNothing);
    await tester.tap(find.text('Girls'));
    await tester.pump();
    expect(find.text('A'), findsNothing);
    expect(find.text('G'), findsOneWidget);
    await tester.tap(find.text('Girls'));
    await tester.pump();
    expect(find.text('A'), findsOneWidget);
    expect(find.text('G'), findsOneWidget);
  });

  testWidgets('no teams message', (tester) async {
    await tester.pumpWidget(MaterialApp(home: TeamSelectView()));
    await tester.tap(find.text('Coed'));
    await tester.pump();
    expect(find.text('No teams found'), findsOneWidget);
  });

  testWidgets('team navigation links', (tester) async {
    final nav = TestIt.stubNavigation();
    await tester.pumpWidget(MaterialApp(home: TeamSelectView()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('A'));
    expect(nav.attempts.length, 1);
    var navAttempt = nav.attempts.first;
    expect(navAttempt.name, '/schedules/team');
    expect(navAttempt.params['id'], 'A');
    nav.attempts.clear();

    await tester.tap(find.text('E'));
    expect(nav.attempts.length, 1);
    navAttempt = nav.attempts.first;
    expect(navAttempt.name, '/schedules/team');
    expect(navAttempt.params['id'], 'E');
  });
}
