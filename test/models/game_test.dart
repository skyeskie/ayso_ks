@Tags(['model'])

import 'package:ayso_ks/models/team.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/test_data.dart';

void main() {
  final gameAvB = TestData.games.first;

  group('hasTeam', () {
    test('hasTeam finds home team', () {
      expect(gameAvB.hasTeam('A'), true);
    });

    test('hasTeam finds away team', () {
      expect(gameAvB.hasTeam('B'), true);
    });

    test('hasTeam false for other team', () {
      expect(gameAvB.hasTeam('C'), false);
    });
  });

  group('byes', () {
    final homeBye = TestData.makeGame(
      id: 'id',
      home: 'A',
      away: Team.BYE_CODE,
      weekNum: 3,
      time: DateTime.now(),
      regionNum: 49,
      field: 'field',
      divisionCode: 'U10B',
    );
    final awayBye = TestData.makeGame(
      id: 'id',
      home: Team.BYE_CODE,
      away: 'C',
      weekNum: 1,
      time: DateTime.now(),
      regionNum: 49,
      field: 'field',
      divisionCode: 'U10B',
    );

    test('bye for home team', () {
      expect(homeBye.isBye(), true);
    });

    test('bye for away team', () {
      expect(awayBye.isBye(), true);
    });

    test('no bye when two teams', () {
      expect(gameAvB.isBye(), false);
    });

    test('return bye opponent', () {
      expect(homeBye.getTeamWithBye(), 'A');
      expect(awayBye.getTeamWithBye(), 'C');
    });

    test('error finding bye team when no bye', () {
      expect(gameAvB.getTeamWithBye, throwsRangeError);
    });
  });

  group('opponent', () {
    test('can return opponent', () {
      expect(gameAvB.getOpponent('A'), 'B');
      expect(gameAvB.getOpponent('B'), 'A');
    });

    test('error when find opponent for team not playing', () {
      expect(() => gameAvB.getOpponent('C'), throwsRangeError);
    });
  });

  //TODO: Test compare ?
}
