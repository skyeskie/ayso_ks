import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../dao/games.dart';
import '../../dao/settings.dart';
import '../../dao/teams.dart';
import '../../models/game.dart';
import '../../models/team.dart';
import '../../widgets/nav_bar.dart';
import 'single_team_game_tile.dart';

class TeamScheduleView extends StatefulWidget {
  const TeamScheduleView({Key key, @required this.teamId}) : super(key: key);

  final String teamId;

  @override
  TeamScheduleState createState() => TeamScheduleState();
}

class TeamScheduleState extends State<TeamScheduleView>
    with GamesInjection, SettingsInjection, TeamsInjection {
  Team _team;
  List<Game> _games;
  bool _favorite;

  Future loaded;

  @override
  void initState() {
    loaded = Future.wait([
      settingsDAO.isTeamSaved(widget.teamId).then((value) => _favorite = value),
      teamsDAO.getTeam(widget.teamId).then((value) => _team = value),
      gamesDAO
          .findForTeam(widget.teamId)
          .then((value) => _games = value.toList(growable: false)),
    ]);
    super.initState();
  }

  void updateFavorite() {
    if (_favorite) {
      settingsDAO.unSaveTeam(_team.code).whenComplete(
            () => setState(() {
              _favorite = false;
            }),
          );
    } else {
      settingsDAO.saveTeamId(_team.code).whenComplete(
            () => setState(() {
              _favorite = true;
            }),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Team Schedule', context),
      body: FutureBuilder(
        future: loaded,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.hasData) {
            return _build(context);
          }

          return Text('Loading');
        },
      ),
    );
  }

  Widget _build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(children: [
          Text('Team ${_team?.code}'),
          OutlineButton.icon(
            icon: Icon(_favorite ? Icons.star : Icons.star_border),
            label: Text(_favorite ? 'UnFavorite' : 'Favorite'),
            onPressed: updateFavorite,
          ),
        ]),
        Row(
          children: [
            Expanded(
              child: Text('Coach'),
              flex: 1,
            ),
            Expanded(
              child: Text(_team?.coach ?? 'To Be Determined'),
              flex: 2,
            ),
          ],
        ),
        FractionallySizedBox(
          child: OutlineButton.icon(
            onPressed: () {},
            icon: Icon(Ionicons.md_call),
            label: Text(_team?.coachTel ?? ''),
          ),
          widthFactor: .667,
          alignment: Alignment.centerRight,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _games?.length ?? 0,
          itemExtent: 50,
          itemBuilder: (_, index) => SingleTeamGameListTile(
            game: _games[index],
            teamId: _team?.code,
          ),
        ),
      ],
    );
  }
}
