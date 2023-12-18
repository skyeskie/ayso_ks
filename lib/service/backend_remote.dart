import 'dart:collection';

import 'package:http/http.dart' as http;

import '../data_config.dart';
import '../models/game.dart';
import '../models/team.dart';
import '../util/date_calc.dart';
import 'backend_interface.dart';
import 'json_model.dart';

class BackendRemote extends BackendInterface {
  JsonModel _json;
  
  Future<JsonModel> _init() async {
    if(_json == null) {
      final response = await http.post(DataConfig.updateUrl, body: {
      });
      _json = JsonModel.fromJsonString(response.body);
    }

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
