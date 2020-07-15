import 'package:ayso_ks/dao/teams.dart';
import 'package:test/test.dart';

import '../mock/test_data.dart';

typedef TeamsDaoGenerator = TeamsDAO Function();

void teamsInterfaceReadSpec(TeamsDaoGenerator initTeamsDao) {
  TeamsDAO dao;

  setUp(() {
    dao = initTeamsDao();
  });

  group('(TeamsDAO) - Read', () {
    test('getTeam resolves to a team', () async {
      final team = await dao.getTeam('B');
      expect(team.code, 'B');
      expect(team.coach, 'coachB');
    });

    test('getTeam invalid lookup', () {
      expect(dao.getTeam('NotATeam'), completion(isNull));
    });

    group('getTeams', () {
      test('returns a list of teams', () async {
        final teams = await dao.getTeams(['C', 'A']);
        expect(teams.map((e) => e.code), containsAll(['A', 'C']));
        expect(teams.length, 2);
      });

      test('handles single item', () async {
        final teams = await dao.getTeams(['E']);
        expect(teams.length, 1);
        expect(teams.first.code, 'E');
      });

      test('ignores invalid teams', () async {
        final teams = await dao.getTeams(['C', 'NotATeam', 'A']);
        expect(teams.map((e) => e.code), containsAll(['A', 'C']));
        expect(teams.length, 2);
      });

      test('empty list on no results', () {
        expect(dao.getTeams([]), completion(isEmpty));
      });
    });
  });

  group('findTeams', () {
    test('filters on region', () async {
      final teams = await dao.findTeams(regionNumber: 49);
      expect(teams.length, 7);
      for (final team in teams) {
        expect(team.region.number, 49);
      }
    });

    test('filters on age', () async {
      final teams = await dao.findTeams(ageString: 'U12');
      expect(teams.length, 5);
      for (final team in teams) {
        expect(team.division.age.cutoff, 12);
      }
    });

    test('filters on gender', () async {
      final teams = await dao.findTeams(genderLong: 'Girls');
      expect(teams.length, 5);
      for (final team in teams) {
        expect(team.division.gender.short, 'G');
      }
    });

    test('returns all with null filter', () async {
      final teams = await dao.findTeams();
      expect(teams.length, TestData.teams.length);
    });
  });
}

final _newTeam = TestData.makeTeam(
  code: 'NEW',
  coach: 'new coach',
  regionNum: 491,
  divisionCode: 'U6C',
  coachTel: '000-000-0000',
);

final _replaceTeam = TestData.makeTeam(
  code: 'C',
  coach: 'new coach',
  regionNum: 208,
  divisionCode: 'U10B',
  coachTel: '000-000-0000',
);

void teamsInterfaceWriteSpec(TeamsDaoGenerator initTeamsDao) {
  TeamsDAO dao;

  setUp(() {
    dao = initTeamsDao();
  });

  group('(TeamsDAO) - Write', () {
    test('add puts teams', () async {
      expect(await dao.getTeam('NEW'), isNull);
      await dao.add([_newTeam]);
      final team = await dao.getTeam('NEW');
      expect(team.code, 'NEW');
      expect(team.coach, 'new coach');
    });

    test('add overwrites existing on key duplicate', () async {
      final initTeam = await dao.getTeam('C');
      expect(initTeam.coach, 'coachC');
      expect(initTeam.coachTel, 'telC');
      await dao.add([_replaceTeam]);
      final team = await dao.getTeam('C');
      expect(team.coach, 'new coach');
      expect(team.coachTel, '000-000-0000');
    });

    test('clear removes all values', () async {
      expect(await dao.findTeams(), isNotEmpty);
      await dao.clear();
      expect(await dao.findTeams(), isEmpty);
    });
  });
}

void teamsInterfaceReadonlySpec(TeamsDaoGenerator initTeamsDao) {
  TeamsDAO dao;

  setUp(() {
    dao = initTeamsDao();
  });

  group('(TeamsDAO) - Readonly', () {
    test('add is no-op', () async {
      expect(await dao.getTeam('NEW'), isNull);
      await dao.add([_newTeam]);
      expect(await dao.getTeam('NEW'), isNull);
    });

    test('add replace is no-op', () async {
      final initTeam = await dao.getTeam('C');
      expect(initTeam.coach, 'coachC');
      expect(initTeam.coachTel, 'telC');
      await dao.add([_replaceTeam]);
      final team = await dao.getTeam('C');
      expect(team.coach, 'coachC');
      expect(team.coachTel, 'telC');
    });

    test('clear is no-op', () async {
      expect(await dao.findTeams(), isNotEmpty);
      await dao.clear();
      expect(await dao.findTeams(), isNotEmpty);
    });
  });
}
