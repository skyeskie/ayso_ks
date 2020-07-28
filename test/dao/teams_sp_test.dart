import 'dart:convert';

import 'package:ayso_ks/dao/sp/teams.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mock/test_data.dart';
import '../mock/test_it.dart';
import 'teams_spec.dart';

void main() {
  final testTeams = TestData.teams.values.map(jsonEncode).toList();
  SharedPreferences.setMockInitialValues({});

  setUp(() async {
    final prefs = await TestIt.I.getAsync<SharedPreferences>();
    return prefs.setStringList(TeamsSpDAO.TEAMS_KEY, testTeams);
  });

  TestIt.I.registerSingletonAsync<SharedPreferences>(
    SharedPreferences.getInstance,
  );

  teamsInterfaceReadSpec(() => TeamsSpDAO());
  teamsInterfaceWriteSpec(() => TeamsSpDAO());
}
