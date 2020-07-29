import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
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
    this.regionNum,
    @required this.week,
    this.ageGroup,
    this.gender,
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
      regionNum: widget.regionNum,
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
                'regionNum': widget.regionNum,
              },
            ),
          ),
          if (hasFilter()) _buildFilterDescription(context),
          FutureBuilder(
            future: games,
            builder: (ctx, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              if (snapshot.hasData) {
                return TwoTeamGameList(games: snapshot.data);
              }

              return Text('Loading...');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDescription(BuildContext context) {
    final fRegion = widget.regionNum != null;
    final fAge = widget.ageGroup != null;
    final fGender = widget.gender != null;
    return GFListTile(
      titleText: 'Filters',
      description: Row(
        children: [
          if (fRegion) Text('Region ${widget.regionNum}'),
          if (fRegion) const SizedBox(width: 15),
          if (fAge) Text('Age ${widget.ageGroup}'),
          if (fAge) const SizedBox(width: 15),
          if (fGender) Text(widget.gender),
        ],
      ),
    );
  }

  bool hasFilter() {
    return (widget.regionNum ?? widget.ageGroup ?? widget.gender) != null;
  }
}
