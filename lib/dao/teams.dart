import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/team.dart';

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
  Future<void> clear();

  Future add(Iterable<Team> teams);
}

mixin TeamsInjection<T extends StatefulWidget> on State<T> {
  final TeamsDAO teamsDAO = Modular.get<TeamsDAO>();

  @override
  void dispose() {
    super.dispose();
    Modular.dispose<TeamsDAO>();
  }
}
