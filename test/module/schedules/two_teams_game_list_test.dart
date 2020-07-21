import 'package:ayso_ks/models/game.dart';
import 'package:ayso_ks/module/schedules/two_team_game_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

//Widget setup skeleton
Widget wrapGameList(Iterable<Game> games) {
  return MaterialApp(
    home: Card(
      child: TwoTeamGameList(
        games: games,
      ),
    ),
  );
}

void main() {
  testWidgets('empty list', (tester) async {
    await tester.pumpWidget(wrapGameList([]));
    expect(find.text('No games found'), findsOneWidget);
  });

  testWidgets('byes display', (tester) async {
    await tester.pumpWidget(wrapGameList([]));
  }, skip: true);

  testWidgets('header displays', (tester) async {
    await tester.pumpWidget(wrapGameList([]));
  }, skip: true);

  testWidgets('game navigation', (tester) async {
    await tester.pumpWidget(wrapGameList([]));
  }, skip: true);
}
