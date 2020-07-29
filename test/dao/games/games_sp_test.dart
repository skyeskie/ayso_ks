import 'dart:convert';

import 'package:ayso_ks/dao/sp/games.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mock/test_data.dart';
import '../../mock/test_it.dart';
import 'games_spec.dart';

void main() {
  final testGames = TestData.games.map(jsonEncode).toList();
  SharedPreferences.setMockInitialValues({});

  setUp(() async {
    final prefs = await TestIt.I.getAsync<SharedPreferences>();
    return prefs.setStringList(GamesSpDAO.GAMES_KEY, testGames);
  });

  TestIt.I.registerSingletonAsync<SharedPreferences>(
    SharedPreferences.getInstance,
  );

  gamesInterfaceReadSpec(() => GamesSpDAO());
  gamesInterfaceWriteSpec(() => GamesSpDAO());

  test('handles uninitialized SharedPrefs keys', () async {
    final dao = GamesSpDAO();
    final prefs = await TestIt.I.getAsync<SharedPreferences>();
    await prefs.remove(GamesSpDAO.GAMES_KEY);
    expect(dao.findForTeam('A'), completion(isEmpty));
    expect(dao.findForTeams(['A', 'B']), completion(isEmpty));
    expect(dao.getGame('111'), completion(isNull));
  });
}
