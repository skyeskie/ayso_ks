import 'package:ayso_ks/dao/settings.dart';
import 'package:ayso_ks/dao/static/teams.dart';
import 'package:ayso_ks/dao/teams.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../mock/test_data.dart';

typedef SettingsDaoGenerator = SettingsDAO Function();

void settingsInterfaceReadSpec(SettingsDaoGenerator initSettingsDao) {
  SettingsDAO dao;

  group('(SettingsDAO) - Read', () {
    setUp(() {
      GetIt.I.registerSingleton<TeamsDAO>(TeamsStaticDAO());
      dao = initSettingsDao();
    });

    tearDown(() {
      GetIt.I.unregister<TeamsDAO>();
    });

    test('returns saved team IDs', () async {
      final teams = await dao.getSavedTeamIDs();
      expect(teams, containsAll(['A', 'B', 'I']));
      expect(teams.length, 3);
    });

    test('returns saved teams', () async {
      final teams = await dao.getSavedTeams();
      expect(teams.map((t) => t.code), containsAll(['A', 'B', 'I']));
      expect(teams.length, 3);
    });

    test('returns saved region number', () {
      expect(dao.getRegionNumber(), completion(49));
    });

    test('returns saved region', () async {
      final region = await dao.getRegion();
      expect(region.number, 49);
    });

    test('isTeamSaved', () {
      expect(dao.isTeamSaved('A'), completion(true));
      expect(dao.isTeamSaved('F'), completion(false));
    });

    test('isAppConfigured true when region is present', () {
      expect(dao.getRegionNumber(), completion(49));
      expect(dao.isAppConfigured(), isTrue);
    });

    test('getSettingsReadonly', () async {
      final settings = await dao.getSettingsReadonly();
      expect(settings.regionNumber, TestData.settings.regionNumber);
      expect(settings.savedTeams, containsAll(TestData.settings.savedTeams));
      expect(settings.savedTeams.length, TestData.settings.savedTeams.length);
    });
  });
}

void settingsInterfaceWriteSpec(SettingsDaoGenerator initSettingsDao) {
  SettingsDAO dao;

  group('(SettingsDAO) - Write', () {
    setUp(() {
      GetIt.I.registerSingleton<TeamsDAO>(TeamsStaticDAO());
      dao = initSettingsDao();
    });

    tearDown(() {
      GetIt.I.unregister<TeamsDAO>();
    });

    test('saves a team', () async {
      final initSaved = await dao.isTeamSaved('E');
      expect(initSaved, isFalse);
      await dao.saveTeamId('E');
      final endSaved = await dao.isTeamSaved('E');
      expect(endSaved, isTrue);
    });

    test('unsaves a team', () async {
      final initSaved = await dao.isTeamSaved('A');
      expect(initSaved, isTrue);
      await dao.unSaveTeam('A');
      final endSaved = await dao.isTeamSaved('A');
      expect(endSaved, isFalse);
    });

    test('saves a region', () async {
      final initSaved = await dao.getRegionNumber();
      expect(initSaved, isNot(208));
      await dao.setRegion(208);
      final endSaved = await dao.getRegionNumber();
      expect(endSaved, 208);
    });

    test('error on try to save invalid region', () {
      expect(() => dao.setRegion(-10), throwsStateError);
    });

    test('isAppConfigured is false on initial load', () {
      //foo
    }, skip: 'TODO: Figure out instantiation');

    test('isAppConfigured is false after a reset', () async {
      await dao.reset();
      expect(dao.isAppConfigured(), isFalse);
    });

    test('after reset returns null region', () async {
      expect(dao.getRegionNumber(), completion(isNotNull));
      expect(dao.getRegion(), completion(isNotNull));
      await dao.reset();
      expect(dao.getRegionNumber(), completion(isNull));
      expect(dao.getRegion(), completion(isNull));
    });

    test('after reset returns no teams', () async {
      expect(await dao.getSavedTeamIDs(), isNotEmpty);
      expect(await dao.getSavedTeams(), isNotEmpty);
      await dao.reset();
      expect(await dao.getSavedTeamIDs(), isEmpty);
      expect(await dao.getSavedTeams(), isEmpty);
    });

    test('after clearSavedTeams returns no teams', () async {
      expect(await dao.getSavedTeamIDs(), isNotEmpty);
      expect(await dao.getSavedTeams(), isNotEmpty);
      await dao.clearSavedTeams();
      expect(await dao.getSavedTeamIDs(), isEmpty);
      expect(await dao.getSavedTeams(), isEmpty);
    });

    test('init sets values', () async {
      await dao.reset();
      expect(dao.isAppConfigured(), isFalse);
      final newSettings = SettingsDataType(
        savedTeams: ['D', 'F'],
        regionNumber: 208,
      );
      await dao.init(
        regionNum: 208,
        savedTeams: ['D', 'F'],
      );
      expect(dao.isAppConfigured(), true);
      expect(await dao.getRegionNumber(), newSettings.regionNumber);
      final newTeams = await dao.getSavedTeamIDs();
      expect(newTeams.length, newSettings.savedTeams.length);
      expect(newTeams, containsAll(newSettings.savedTeams));
    });
  });
}

void settingsInterfaceReadonlySpec(SettingsDaoGenerator initSettingsDao) {
  SettingsDAO dao;

  group('(SettingsDAO) - Readonly', () {
    setUp(() {
      dao = initSettingsDao();
    });

    test('will not save a team', () async {
      await dao.saveTeamId('E');
      expect(dao.isTeamSaved('E'), completion(isFalse));
    });

    test('will not remove a team', () async {
      await dao.unSaveTeam('A');
      expect(dao.isTeamSaved('A'), completion(isTrue));
    });

    test('will not save region', () async {
      await dao.setRegion(208);
      expect(dao.getRegionNumber(), completion(49));
    });

    test('isAppConfigured is true on init', () {
      //foo
    }, skip: 'TODO: Figure out instantiation');

    test('isAppConfigured is true after reset', () async {
      await dao.reset();
      expect(dao.isAppConfigured(), isTrue);
    });

    test('has data after reset', () async {
      await dao.reset();
      expect(dao.getRegionNumber(), completion(49));
      expect(dao.getSavedTeamIDs(), completion(isNotEmpty));
    });

    test('has data after clear teams', () async {
      await dao.clearSavedTeams();
      expect(dao.getSavedTeamIDs(), completion(isNotEmpty));
    });

    test('init does not set values', () async {
      await dao.init(regionNum: 208);
      expect(dao.getRegionNumber(), completion(49));
    });
  });
}
