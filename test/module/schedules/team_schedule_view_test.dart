import 'package:ayso_ks/module/schedules/team_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/test_it.dart';

void main() {
  setUp(() {
    TestIt.registerTeamsDAO();
    TestIt.registerGamesDAO();
  });
  tearDown(TestIt.clean);

  testWidgets('display favorite', (tester) async {
    TestIt.registerSettings();
    await tester.pumpWidget(MaterialApp(home: TeamScheduleView(teamId: 'A')));
    expect(find.text('Loading...'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Loading...'), findsNothing);

    expect(find.text('Coach coachA'), findsOneWidget);
    expect(find.text('Team A'), findsOneWidget);
    expect(find.text('Region 49 - U10 Boys'), findsOneWidget);
    expect(find.byIcon(Icons.call), findsOneWidget);
  });

  testWidgets('favorite toggle', (tester) async {
    TestIt.registerSettingsMutable(regionNumber: 49, savedTeams: []);
    await tester.pumpWidget(MaterialApp(home: TeamScheduleView(teamId: 'A')));
    await tester.pumpAndSettle();
    expect(find.text('Favorite'), findsOneWidget);
    expect(find.text('UnFavorite'), findsNothing);

    await tester.tap(find.byIcon(Icons.star_border));
    await tester.pump();
    expect(find.text('Favorite'), findsNothing);
    expect(find.text('UnFavorite'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.star));
    await tester.pump();
    expect(find.text('Favorite'), findsOneWidget);
    expect(find.text('UnFavorite'), findsNothing);
  });
}
