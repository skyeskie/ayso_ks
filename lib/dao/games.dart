import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/game.dart';

/// Interface for accessing Game objects
///
/// While async access means this can be direct remote access,
/// this is primarily intended for local caching
abstract class GamesDAO {
  /// Lookup a single game
  ///
  /// @param id - Game ID
  Future<Game> getGame(String id);

  /// Lookup games with optional filters
  ///
  /// @param regionNum - numeric identifier for region. Unique nationwide
  /// @param ageGroup - String of form U10. Must be in [AgeGroup.AGES]
  /// @param gender - Long string for gender. Must be in [Gender.GENDERS]
  /// @param week - week number of season. Constraints [1, maxWeeks]
  Future<Iterable<Game>> findGames({
    int regionNum,
    String ageGroup,
    String gender,
    int week,
  });

  /// Lookup all games for a single team
  ///
  /// @param teamID - ID found in TeamsDAO
  /// If team doesn't exist, returns empty iterable
  Future<Iterable<Game>> findForTeam(String teamId);

  /// Lookup all games for a single team
  ///
  /// @param teamIDs - Array of team IDs
  /// If team doesn't exist, returns empty iterable
  Future<Iterable<Game>> findForTeams(Iterable<String> teamIds);

  /// Clears all saved data.
  ///
  /// No-op if implementation is read-only
  Future<void> clear();

  /// Add game objects, replacing duplicate IDs
  ///
  /// No-op if implementation is read-only
  Future add(Iterable<Game> games);
}

mixin GamesInjection<T extends StatefulWidget> on State<T> {
  /// Access for Game objects
  final GamesDAO gamesDAO = GetIt.I.get<GamesDAO>();
}
