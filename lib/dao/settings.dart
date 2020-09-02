import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/region.dart';
import '../models/team.dart';

/// Object for accessing user settings and app configuration
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

  /// Get an immutable object with all settings
  Future<SettingsDataType> getSettingsReadonly();

  /// Perform any backend initialization
  /// If not required should be no-op
  /// If `isAppConfigured()===true`, should be no-op
  Future<void> init({num regionNum, Iterable<String> savedTeams});

  /// Returns if all required settings are present
  /// @required `region` - user's home region
  /// This must be synchronous, since it's used for the route interceptor
  bool isAppConfigured();

  /// DataVersion is used to feed backends that get incremental updates
  ///
  /// Returns null if not set
  Future<String> getDataVersion();

  /// Persist DataVersion. See BackendInterface for format
  Future setDataVersion(String version);

  /// Clear all saved settings
  /// After call, `isAppConfigured()` should return false
  Future<void> reset();
}

/// Data wrapper class for settings, so can be passed as single object
class SettingsDataType {
  /// Create immutable settings object
  ///
  /// Create a new one if need to change
  const SettingsDataType({
    this.regionNumber = 49,
    this.savedTeams = const [],
    this.dataVersion = 'no-version',
  });

  /// Region number - positive integer uniquely identifying region in US
  final int regionNumber;

  /// List of Team IDs that the user has marked as favorite
  final List<String> savedTeams;

  /// Version string of the data from BackendInterface
  ///
  /// See specific interfaces for what this structure means
  final String dataVersion;
}

/// Mixin for widget to automatically get reference to the Settings DAO
mixin SettingsInjection<T extends StatefulWidget> on State<T> {
  /// Object to access settings
  final SettingsDAO settingsDAO = GetIt.I.get<SettingsDAO>();
}
