import 'package:get_it/get_it.dart';

import '../../dao/games.dart';
import '../../dao/settings.dart';
import '../../dao/teams.dart';
import '../../dao/week_cache.dart';
import '../../service/backend_interface.dart';

/// Control class for managing backend and caching DAOs
class DataController {
  final _backend = GetIt.I.get<BackendInterface>();
  final _gamesDao = GetIt.I.get<GamesDAO>();
  final _settingsDao = GetIt.I.get<SettingsDAO>();
  final _teamsDao = GetIt.I.get<TeamsDAO>();
  final _weekCacheDao = GetIt.I.get<WeekCacheDAO>();

  /// Refresh data from backend and put to the caching DAOs
  Future refreshData({bool updateAll = false}) async {
    final dv = updateAll ? null : (await _settingsDao.getDataVersion());
    return Future.wait([
      _gamesDao.add(await _backend.getGames(pastVersion: dv)),
      _teamsDao.add(await _backend.getTeams(pastVersion: dv)),
      _weekCacheDao.init(await _backend.getWeekStarts(pastVersion: dv)),
      _settingsDao.setDataVersion(await _backend.getDataVersion()),
    ], eagerError: true);
  }

  /// Shortcut for determining if app is configured
  ///
  /// This is true iff a home region has been set
  bool get isAppConfigured => _settingsDao.isAppConfigured();

  /// Shortcut to set the home region
  Future configureRegion(int regionNum) => _settingsDao.setRegion(regionNum);
}
