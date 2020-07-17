import '../models/game.dart';
import '../models/team.dart';

abstract class BackendInterface {
  /// Does any necessary setup for backend requests. Update params mean
  /// subsequent calls to `getTeams()` and `getGames()` are update requests.
  /// Otherwise request is for full data and functions will return entire data
  ///
  /// @param curVersion - string version for current data version
  /// - Exact use depends on backend implementation
//  Future init(String curVersion);

  Future<Iterable<Team>> getTeams({String pastVersion});

  Future<Iterable<Game>> getGames({String pastVersion});

  /// @return Date[] - Full initialization; sets week cache with values
  /// @return empty array - Keep existing week cache
  /// @return null - Have the `DataControlService` handle the week cache
  Future<Iterable<DateTime>> getWeekStarts({String pastVersion});

  Future<String> getDataVersion({String pastVersion});
}
