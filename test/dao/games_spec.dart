import 'package:ayso_ks/dao/games.dart';
import 'package:test/test.dart';

import '../mock/test_data.dart';

typedef GamesDaoGenerator = GamesDAO Function();

void gamesInterfaceReadSpec(GamesDaoGenerator initGamesDao) {
  GamesDAO dao;

  group('(GamesDAO) - Read', () {
    setUp(() {
      dao = initGamesDao();
    });

    group('getGame', () {
      test('resolves to a game', () async {
        final game = await dao.getGame('122');
        expect(game.id, '122');
      });

      test('returns null on invalid lookup', () {
        expect(dao.getGame('ZZZ'), completion(isNull));
      });
    });

    group('findGames', () {
      test('filter on region', () async {
        final games = await dao.findGames(regionId: 49);
        expect(games.length, 10);
        for (final game in games) {
          expect(game.region.number, 49);
        }
      });

      test('filter on age', () async {
        final games = await dao.findGames(ageGroup: 'U10');
        expect(games.length, 8);
        for (final game in games) {
          expect(game.division.age.cutoff, 10);
        }
      });

      test('filter on gender', () async {
        final games = await dao.findGames(gender: 'Boys');
        expect(games.length, 8);
        for (final game in games) {
          expect(game.division.gender.short, 'B');
        }
      });

      test('filter on week', () async {
        final games = await dao.findGames(week: 2);
        expect(games.length, 4);
        for (final game in games) {
          expect(game.weekNum, 2);
        }
      });

      test('returns all games on null filters', () async {
        final games = await dao.findGames();
        expect(games.length, TestData.games.length);
      });
    });

    group('findForTeam', () {
      test('returns games', () async {
        final games = await dao.findForTeam('A');
        expect(games.length, 4);
        for (final game in games) {
          expect(game.hasTeam('A'), true);
        }
      });

      test('returns empty list for no games', () async {
        final games = await dao.findForTeam('NotATeam');
        expect(games, isEmpty);
      });
    });

    group('findForTeams', () {
      test('returns games for 1 team', () async {
        final games = await dao.findForTeams(['B']);
        expect(games.length, 4);
        for (final game in games) {
          expect(game.hasTeam('B'), true);
        }
      });

      test('returns games for 3 teams', () async {
        final games = await dao.findForTeams(['A', 'B', 'C']);
        expect(games.length, 8);
        for (final game in games) {
          expect(
            game.hasTeam('A') || game.hasTeam('B') || game.hasTeam('C'),
            true,
          );
        }
      });

      test('returns empty list for no teams', () async {
        final games = await dao.findForTeams([]);
        expect(games, isEmpty);
      });

      test('return ignores invalid teams', () async {
        final games = await dao.findForTeams(['B', 'NotATeam']);
        expect(games.length, 4);
        for (final game in games) {
          expect(game.hasTeam('B'), true);
        }
      });
    });
  });
}

void gamesInterfaceWriteSpec(GamesDaoGenerator initGamesDao) {
  GamesDAO dao;

  group('(GamesDAO) - write', () {
    setUp(() {
      dao = initGamesDao();
    });

    final newGame = TestData.mkGame(
        'NEW', 'B', 'A', 3, TestData.startTime(3, 8), 49, 'map', 'U10B');
    final replace = TestData.mkGame(
        '112', 'D', 'C', 1, TestData.startTime(1, 8), 49, 'map', 'U10B');
    test('adds a game', () async {
      await dao.add([newGame]);
      final game = await dao.getGame('NEW');
      expect(game.id, 'NEW');
      expect(game.home, 'B');
    });

    test('keeps existing games on add', () async {
      final initLength = TestData.games.length;
      await dao.add([newGame]);
      final games = await dao.findGames();
      expect(games.length, initLength + 1);
    });

    test('replaces games instead of adding duplicate IDs', () async {
      final initLength = TestData.games.length;
      final initGame = await dao.getGame(replace.id);
      expect(initGame.home, 'C');
      expect(initGame.away, 'D');
      expect(initGame.field, 'map2');
      await dao.add([replace]);
      final games = await dao.findGames();
      expect(games.length, initLength);
      final repGame = await dao.getGame(replace.id);
      expect(repGame.away, 'C');
      expect(repGame.home, 'D');
      expect(repGame.field, 'map');
    });

//    test('can remove a game', () async {
//      final initLength = StaticData.games.length;
//      final initGame = await dao.getGame('312');
//      await dao.removeGame('312');
//      expect(dao.getGame('312'), completion(isNull));
//      final games = await dao.findGames();
//      expect(games.length, initLength - 1);
//    });

    test('clear()', () async {
      var games = await dao.findGames();
      expect(games, isNotEmpty);
      await dao.clear();
      games = await dao.findGames();
      expect(games, isEmpty);
    });
  });
}

void gamesInterfaceReadonlySpec(GamesDaoGenerator initGamesDao) {
  GamesDAO dao;

  group('(GamesDAO) - write', () {
    setUp(() {
      dao = initGamesDao();
    });

    test('clear is no-op', () async {
      await dao.clear();
      expect(await dao.findGames(), isNotEmpty);
    });

    test('add is no-op', () async {
      final newGame = TestData.mkGame(
          'NEW', 'B', 'A', 3, TestData.startTime(3, 8), 49, 'map', 'U10B');
      await dao.add([newGame]);
      expect(dao.getGame('NEW'), completion(isNull));
    });
  });
}