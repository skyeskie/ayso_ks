import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../dao/games.dart';
import '../../dao/week_cache.dart';
import '../../models/game.dart';
import '../../widgets/nav_bar.dart';
import 'two_team_game_list.dart';
import 'week_bar.dart';

class WeekScheduleView extends StatefulWidget {
  const WeekScheduleView({int week}) : _week = week;

  final int _week;

  @override
  _WeekScheduleViewState createState() => _WeekScheduleViewState();
}

class _WeekScheduleViewState extends State<WeekScheduleView>
    with GamesInjection, WeekCacheInjection {
  Future<Iterable<Game>> games;

  int week;

  @override
  void initState() {
    week = widget._week ?? weekCache.getCurrentWeek();
    games = gamesDAO.findGames(week: week);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Region 49 Schedule', context),
      body: Column(
        children: [
          WeekBar(
            week: week,
            maxWeeks: weekCache.getMaxWeeks(),
            navigate: (week) =>
                Modular.link.pushReplacementNamed('/week/$week'),
          ),
          FutureBuilder(
            future: games,
            builder: (ctx, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              if (snapshot.hasData) {
                print('Data:');
                print(snapshot.data);
                return TwoTeamGameList(games: snapshot.data);
              }

              return Text('Loading');
            },
          ),
        ],
      ),
    );
  }
}
