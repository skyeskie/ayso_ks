import 'package:ayso_ks/dao/sp/settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mock/test_data.dart';
import '../../mock/test_it.dart';
import 'settings_spec.dart';

void main() {
  final testSettings = TestData.settings;
  SharedPreferences.setMockInitialValues({});

  setUp(() async {
    final prefs = await GetIt.I.getAsync<SharedPreferences>();
    return Future.wait([
      prefs.setStringList(SettingsSpDao.TEAMS_KEY, testSettings.savedTeams),
      prefs.setInt(SettingsSpDao.REGION_KEY, testSettings.regionNumber),
      prefs.setString(SettingsSpDao.VERSION_KEY, 'test-version'),
    ]);
  });

  TestIt.I.registerSingletonAsync<SharedPreferences>(
    SharedPreferences.getInstance,
  );

  settingsInterfaceReadSpec(
    () => SettingsSpDao(),
  );

  settingsInterfaceWriteSpec(
    () => SettingsSpDao(),
  );
}
