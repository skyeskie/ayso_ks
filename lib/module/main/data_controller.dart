import 'package:flutter_modular/flutter_modular.dart';

import '../../dao/games.dart';
import '../../dao/settings.dart';
import '../../dao/teams.dart';
import '../../dao/week_cache.dart';
import '../../service/backend_interface.dart';

class DataController extends Disposable {
  final _backend = Modular.get<BackendInterface>();
  final _gamesDao = Modular.get<GamesDAO>();
  final _settingsDao = Modular.get<SettingsDAO>();
  final _teamsDao = Modular.get<TeamsDAO>();
  final _weekCacheDao = Modular.get<WeekCacheDAO>();

  Future refreshData({bool updateAll = false}) async {
    final dv = updateAll ? null : (await _settingsDao.getDataVersion());
    return Future.wait([
      _gamesDao.add(await _backend.getGames(pastVersion: dv)),
      _teamsDao.add(await _backend.getTeams(pastVersion: dv)),
      _weekCacheDao.init(await _backend.getWeekStarts(pastVersion: dv)),
      _settingsDao.setDataVersion(await _backend.getDataVersion()),
    ], eagerError: true);
  }

  bool get isAppConfigured => _settingsDao.isAppConfigured();

  Future configureRegion(int regionNum) => _settingsDao.setRegion(regionNum);

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
