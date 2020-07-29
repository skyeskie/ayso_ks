import 'package:ayso_ks/dao/static/games.dart';

import 'games_spec.dart';

void main() {
  gamesInterfaceReadSpec(() => GamesStaticDAO());
  gamesInterfaceReadonlySpec(() => GamesStaticDAO());
}
