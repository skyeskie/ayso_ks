import 'package:ayso_ks/module/schedules/single_team_game_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/test_data.dart';
import '../../mock/test_it.dart';

void main() {
  tearDown(TestIt.clean);

  testWidgets('display home', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SingleTeamGameListTile(teamId: 'A', game: TestData.games[0]),
    ));

    expect(find.text('Feb 6, 8:00'), findsOneWidget);
    expect(find.text('vs B'), findsOneWidget);
    expect(find.text('Region 49'), findsOneWidget);
    expect(find.text('Field map'), findsOneWidget);
  });

  testWidgets('display away + navigation', (tester) async {
    final nav = TestIt.stubNavigation();
    await tester.pumpWidget(MaterialApp(
      home: SingleTeamGameListTile(teamId: 'B', game: TestData.games[0]),
    ));

    expect(find.text('at A'), findsOneWidget);

    await tester.tap(find.text('at A'));
    expect(nav.attempts.length, 1);
    expect(nav.attempts.first.name, '/schedules/game');
    expect(nav.attempts.first.params['id'], '111');
  });

  testWidgets('display bye', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SingleTeamGameListTile(teamId: 'A', game: TestData.games[12]),
    ));

    expect(find.text('BYE'), findsOneWidget);
    expect(find.text('vs -'), findsNothing);
    expect(find.text('at -'), findsNothing);
    expect(find.text('-'), findsNothing);
  });
}
