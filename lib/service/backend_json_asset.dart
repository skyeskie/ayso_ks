import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:time/time.dart';

import '../models/game.dart';
import '../models/team.dart';
import 'backend_interface.dart';
import 'json_model.dart';

/// Data implementation that extracts data from a Json file in Assets
///
/// Specific file is configured as "res/data.json"
class BackendJsonAsset implements BackendInterface {
  JsonModel _json;

  Future<JsonModel> _init() async {
    _json ??= await rootBundle.loadStructuredData<JsonModel>(
      'res/data.json',
      JsonModel.parse, // ignore: unnecessary_lambdas
    );
    return Future.value(_json);
  }

  @override
  Future<Iterable<Game>> getGames({String pastVersion}) {
    return _init().then((value) => value.games);
  }

  @override
  Future<Iterable<Team>> getTeams({String pastVersion}) {
    return _init().then((value) => value.teams);
  }

  @override
  Future<Iterable<DateTime>> getWeekStarts({String pastVersion}) {
    return _init().then((value) {
      final starts = SplayTreeSet.of(
        value.games.map((e) => e.startTime.dateOnly().previousWednesday()),
      );
      return starts;
    });
  }

  @override
  Future<String> getDataVersion({String pastVersion}) {
    return _init().then((value) => value.version);
  }
}

/// Extensions on [DateTime] to assist in calculating week starts
extension WeekStartCalc on DateTime {
  /// Returns the date portion, with time values zeroed out
  DateTime dateOnly() {
    return DateTime(year, month, day);
  }

  /// Changes the day so that it is the closest Wednesday, going backwards
  ///
  /// When called on a Wednesday, returns an exact copy
  DateTime previousWednesday() {
    var diff = weekday - DateTime.wednesday;
    if (diff < 0) diff += 7;
    return this - diff.days;
  }
}
