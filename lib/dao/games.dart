import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/game.dart';

abstract class GamesDAO {
  /// Lookup a single game
  /// @param id - Game ID
  /// @returns Promise<Game[]>
  Future<Game> getGame(String id);

  /// Lookup games with optional filters
  /// TODO: rename regionId to regionNum
  Future<Iterable<Game>> findGames({
    int regionId,
    String ageGroup,
    String gender,
    int week,
  });

  /// Lookup all games for a single team
  /// @param teamID - ID found in TeamsDAO
  /// @returns Promise<Game[]>
  Future<Iterable<Game>> findForTeam(String teamId);

  /// Lookup all games for a single team
  /// @param teamIDs - Array of team IDs
  /// @returns Promise<Game[]>
  Future<Iterable<Game>> findForTeams(Iterable<String> teamIds);

  /// Clears all saved data.
  /// Promise is returned for chaining actions
  Future<void> clear();

  Future add(Iterable<Game> games);
}

mixin GamesInjection<T extends StatefulWidget> on State<T> {
  final GamesDAO gamesDAO = GetIt.I.get<GamesDAO>();
}
