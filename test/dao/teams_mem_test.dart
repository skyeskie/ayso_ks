import 'package:ayso_ks/dao/mem/teams.dart';

import '../mock/test_data.dart';
import 'teams_spec.dart';

void main() {
  teamsInterfaceReadSpec(() => TeamsInMemoryDAO(init: TestData.teams.values));
  teamsInterfaceWriteSpec(() => TeamsInMemoryDAO(init: TestData.teams.values));
}
