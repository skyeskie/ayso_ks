import '../models/game.dart';
import '../models/team.dart';

abstract class Backend {
  /// Does any necessary setup for backend requests. Update params mean
  /// subsequent calls to `getTeams()` and `getGames()` are update requests.
  /// Otherwise request is for full data and functions will return entire data
  ///
  /// @param curVersion - string version for current data version
  /// - Exact use depends on backend implementation
  Future init(String curVersion);

  Future<String> getDataVersion();

  Future<Iterable<Team>> getTeams();

  Future<Iterable<Game>> getGames();

  /// Used to provide initial settings.
  /// @return SettingsDataType - settings with defaults
  /// @return null - don't initialize any settings
  /// - By default, region is selected and favorite teams is blank
  Future<SettingsDataType> getSettings();

  /// @return Date[] - Full initialization; sets week cache with values
  /// @return empty array - Keep existing week cache
  /// @return null - Have the `DataControlService` handle the week cache
  Future<Iterable<DateTime>> getWeekStarts();
}

class SettingsDataType {
  const SettingsDataType({
    this.regionNumber = 49,
    this.savedTeams = const [],
  });

  final int regionNumber;
  final List<String> savedTeams;
}
