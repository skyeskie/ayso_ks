import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../dao/games.dart';
import '../../dao/settings.dart';
import '../../dao/teams.dart';
import '../../models/game.dart';
import '../../models/team.dart';
import 'single_team_game_tile.dart';

class TeamScheduleView extends StatefulWidget {
  @override
  TeamScheduleState createState() => TeamScheduleState();
}

class TeamScheduleState extends State<TeamScheduleView>
    with GamesInjection, SettingsInjection, TeamsInjection {
  Team _team;
  List<Game> _games;

  //TODO: Route data through and put in FutureBuilders

  //TODO: Handle star/favorite toggle

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        child: Column(children: [
          Row(children: [
            Text('Team ${_team.code}'),
            OutlineButton.icon(
              icon: Icon(Ionicons.md_star_outline), //TOGGLE, + Text
              label: Text('Favorite'),
              onPressed: () {},
            ),
          ]),
          Row(children: [
            Expanded(
              child: Text('Coach'),
              flex: 1,
            ),
            Expanded(
              child: Text(_team.coach ?? 'To Be Determined'),
              flex: 2,
            ),
          ]),
          FractionallySizedBox(
            child: OutlineButton.icon(
              onPressed: () {},
              icon: Icon(Ionicons.md_call),
              label: Text(_team.coachTel),
            ),
            widthFactor: .667,
            alignment: Alignment.centerRight,
          ),
        ]),
      ),
      Card(
        child: ListView.builder(
          itemBuilder: (_, index) => SingleTeamGameListTile(
            game: _games[index],
            teamId: _team.code,
          ),
        ),
      ),
    ]);
  }
}
