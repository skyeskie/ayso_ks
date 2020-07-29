import 'package:ayso_ks/dao/static/teams.dart';

import 'teams_spec.dart';

void main() {
  teamsInterfaceReadSpec(() => TeamsStaticDAO());
  teamsInterfaceReadonlySpec(() => TeamsStaticDAO());
}
