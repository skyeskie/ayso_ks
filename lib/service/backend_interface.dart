import '../models/game.dart';
import '../models/team.dart';

/// Interface for getting non-cached data, whether static or remote
abstract class BackendInterface {
  /// Get teams and/or updates returned from backend
  ///
  /// Depending on implementation, [pastVersion] may be used to send partial
  /// updates. Without it, the full list of teams will be returned
  Future<Iterable<Team>> getTeams({String pastVersion});

  /// Get games and/or updates returned from backend
  ///
  /// Depending on implementation, [pastVersion] may be used to send partial
  /// updates. Without it, the full list of games will be returned
  Future<Iterable<Game>> getGames({String pastVersion});

  /// @return Date[] - Full initialization; sets week cache with values
  Future<Iterable<DateTime>> getWeekStarts({String pastVersion});

  /// Get the version of the current data
  Future<String> getDataVersion({String pastVersion});
}
