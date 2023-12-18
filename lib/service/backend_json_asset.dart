import 'dart:collection';

import 'package:flutter/services.dart';

import '../models/game.dart';
import '../models/team.dart';
import '../util/date_calc.dart';
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
