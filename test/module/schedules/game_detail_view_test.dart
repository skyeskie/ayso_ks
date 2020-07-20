import 'package:ayso_ks/models/game.dart';
import 'package:ayso_ks/module/schedules/game_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/test_it.dart';

void main() {
  tearDown(TestIt.clean);

  testWidgets('view', (tester) async {
    TestIt.registerTeamsDAO();
    TestIt.registerGamesDAO();
    await tester.pumpWidget(MaterialApp(home: GameDetailView(id: '111')));
    expect(find.text('Loading...'), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.text('Home Team'), findsOneWidget);
    expect(find.text('Away Team'), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    expect(find.text('Call'), findsNWidgets(2));
    expect(find.text('Field map'), findsOneWidget);
    expect(find.text('Region 49'), findsOneWidget);
  });

  testWidgets('navigation', (tester) async {
    TestIt.registerTeamsDAO();
    TestIt.registerGamesDAO();
    final nav = TestIt.stubNavigation();
    await tester.pumpWidget(MaterialApp(home: GameDetailView(id: '312')));
    await tester.pumpAndSettle();

    expect(find.text('Directions'), findsOneWidget);
    expect(find.text('Field Map'), findsOneWidget);
    await tester.tap(find.text('Directions'));
    await tester.tap(find.text('Field Map'));
    expect(nav.attempts.length, 2);
    expect(nav.attempts.first.name, '/region/map');
    expect(nav.attempts.first.params['regionNum'], 49);
    expect(nav.attempts.last.name, '/region/field');
    expect(nav.attempts.last.params['regionNum'], 49);
  });

  testWidgets('home bye', (tester) async {
    TestIt.registerTeamsDAO();
    TestIt.registerGamesDAO();
    await tester.pumpWidget(MaterialApp(home: GameDetailView(id: '501')));
    await tester.pumpAndSettle();

    expect(find.text('BYE'), findsOneWidget);
    expect(find.text('Call'), findsOneWidget);
    expect(find.text('Home Team'), findsNothing);
    expect(find.text('Away Team'), findsNothing);
    expect(find.text('Team'), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(find.text(Game.BYE_TEAM), findsNothing);
  });

  testWidgets('away bye', (tester) async {
    TestIt.registerTeamsDAO();
    TestIt.registerGamesDAO();
    await tester.pumpWidget(MaterialApp(home: GameDetailView(id: '502')));
    await tester.pumpAndSettle();

    expect(find.text('BYE'), findsOneWidget);
    expect(find.text('Call'), findsOneWidget);
    expect(find.text('Home Team'), findsNothing);
    expect(find.text('Away Team'), findsNothing);
    expect(find.text('Team'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    expect(find.text(Game.BYE_TEAM), findsNothing);
  });

  testWidgets('not found', (tester) async {
    TestIt.registerTeamsDAO();
    TestIt.registerGamesDAO();
    await tester.pumpWidget(MaterialApp(home: GameDetailView(id: 'INVALID')));
    await tester.pumpAndSettle();

    expect(find.text('No games found'), findsOneWidget);
  });
}
