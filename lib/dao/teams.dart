import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/team.dart';

/// Interface for accessing Team objects
///
/// While async access means this can be direct remote access,
/// this is primarily intended for local caching
abstract class TeamsDAO {
  /// Gets single team
  /// @param id - `Team.code`
  /// Errors in Promise.reject and not thrown
  Future<Team> getTeam(String id);

  /// Gets multiple teams by direct lookup
  /// @param ids - Array of team codes (`Team.code`)
  /// Errors in Promise.reject and not thrown
  Future<Iterable<Team>> getTeams(Iterable<String> ids);

  /// Gets multiple teams by search
  /// @param regionNumber (optional) - `Region.number`
  /// @param ageString (optional) - format U# - see `AgeGroup.toString()`
  /// @param genderLong (optional) - `Gender.long`
  /// If parameters are undefined or `null`, any value for that field works
  /// Errors in Promise.reject and not thrown
  Future<Iterable<Team>> findTeams({
    int regionNumber,
    String ageString,
    String genderLong,
  });

  /// Clears all saved data.
  ///
  /// No-op if implementation is read-only
  Future<void> clear();

  /// Add game objects, replacing duplicate IDs
  ///
  /// No-op if implementation is read-only
  Future add(Iterable<Team> teams);
}

mixin TeamsInjection<T extends StatefulWidget> on State<T> {
  /// Access for Team objects
  final TeamsDAO teamsDAO = GetIt.I.get<TeamsDAO>();
}
