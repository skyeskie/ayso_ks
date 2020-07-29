import 'package:ayso_ks/dao/mem/games.dart';

import '../../mock/test_data.dart';
import 'games_spec.dart';

void main() {
  gamesInterfaceReadSpec(() => GamesInMemoryDAO(init: TestData.games));
  gamesInterfaceWriteSpec(() => GamesInMemoryDAO(init: TestData.games));
}
