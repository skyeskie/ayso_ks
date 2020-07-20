import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

import '../../dao/games.dart';
import '../../dao/week_cache.dart';
import '../../models/game.dart';
import '../../routes_config.dart';
import '../../widgets/nav_bar.dart';
import 'two_team_game_list.dart';
import 'week_bar.dart';

class SearchResultsView extends StatefulWidget {
  const SearchResultsView({
    key,
    @required this.regionNum,
    @required this.week,
    @required this.ageGroup,
    @required this.gender,
  }) : super(key: key);

  final int regionNum;
  final int week;
  final String ageGroup;
  final String gender;

  @override
  _SearchResultsViewState createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView>
    with GamesInjection, WeekCacheInjection {
  Future<Iterable<Game>> games;

  @override
  void initState() {
    games = gamesDAO.findGames(
      regionId: widget.regionNum,
      week: widget.week,
      ageGroup: widget.ageGroup,
      gender: widget.gender,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Search Results', context),
      body: Column(
        children: [
          WeekBar(
            week: widget.week,
            maxWeeks: weekCache.getMaxWeeks(),
            navigate: (week) => Routing.sailor(
              '/schedules/filtered',
              navigationType: NavigationType.pushReplace,
              params: {
                'week': week,
                'age': widget.ageGroup,
                'gender': widget.gender,
                'region': widget.regionNum,
              },
            ),
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
