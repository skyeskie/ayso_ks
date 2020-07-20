import 'package:ayso_ks/module/schedules/favorites_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/test_it.dart';

void main() {
  tearDown(TestIt.clean);

  testWidgets('saved teams', (tester) async {
    TestIt.registerSettings();
    TestIt.registerGamesDAO();
    final nav = TestIt.stubNavigation();
    await tester.pumpWidget(MaterialApp(home: FavoritesListView()));
    expect(find.text('Loading'), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.text('My Teams'), findsOneWidget);
    expect(find.text('No saved teams'), findsNothing);

    //Test Team buttons
    expect(find.text('Team A'), findsOneWidget);
    await tester.tap(find.text('Team A'));
    expect(nav.attempts.length, 1);
    expect(nav.attempts.first.name, '/schedules/team');
    expect(nav.attempts.first.params['id'], 'A');
  });

  testWidgets('no saved teams', (tester) async {
    TestIt.registerGamesDAO();
    TestIt.registerTeamsDAO();
    TestIt.registerSettingsMutable(regionNumber: 49);
    final nav = TestIt.stubNavigation();
    await tester.pumpWidget(MaterialApp(home: FavoritesListView()));
    await tester.pumpAndSettle();

    expect(find.text('No saved teams'), findsOneWidget);
    expect(find.text('Find Team'), findsOneWidget);

    await tester.tap(find.text('Find Team'));
    expect(nav.attempts.length, 1);
    expect(nav.attempts.first.name, '/search/teams');
  });
}
