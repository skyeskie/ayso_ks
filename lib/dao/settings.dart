import 'dart:async';

import '../models/region.dart';
import '../models/team.dart';

abstract class SettingsDAO {
  /// Gets a list of the IDs the saved teams
  /// List will have no duplicates
  Future<Iterable<String>> getSavedTeamIDs();

  /// Gets the team objects corresponding to the save team IDs
  /// Only the ID should be stored here
  Future<Iterable<Team>> getSavedTeams();

  /// @function saveTeam
  /// @desc Saves a team as a favorite.
  /// If team already saved, does no-op to prevent duplicates
  /// @param {String} team - unique ID for team
  Future<void> saveTeamId(String teamId);

  /// Removes a team from favorites.
  /// Checks all items so will remove all if there are duplicates
  /// @param {String} team - unique ID of team to remove
  Future<void> unSaveTeam(String teamId);

  /// Checks if team is saved
  /// @param {String} team - unique ID of team
  Future<bool> isTeamSaved(String teamId);

  /// Removes all teams from saved list
  Future<void> clearSavedTeams();

  /// Gets the saved region number
  /// Only use this function if just need the Region.number value
  /// @returns the region number
  Future<int> getRegionNumber();

  /// Gets the saved region object.
  /// Use this if using the region itself
  /// @returns Region object for the saved region
  Future<Region> getRegion();

  /// @function setRegion
  /// @desc Persists the current region to configuration
  /// @param region - the region ID
  Future<void> setRegion(int regionNum);

  /// Perform any backend initialization
  /// If not required should be no-op
  /// If `isAppConfigured()===true`, should be no-op
  Future<void> init({num regionNum, Iterable<String> savedTeams});

  /// Returns if all required settings are present
  /// @required `region` - user's home region
  /// This must be synchronous, since it's used for the route interceptor
  bool isAppConfigured();

  /// Clear all saved settings
  /// After call, `isAppConfigured()` should return false
  Future<void> reset();
}
