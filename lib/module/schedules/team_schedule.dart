import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../dao/games.dart';
import '../../dao/settings.dart';
import '../../dao/teams.dart';
import '../../models/game.dart';
import '../../models/team.dart';
import '../../widgets/nav_bar.dart';
import 'single_team_game_tile.dart';

/// View that shows all the games and info for a single team
class TeamScheduleView extends StatefulWidget {
  /// Constructor
  const TeamScheduleView({Key key, @required this.teamId}) : super(key: key);

  ///  Identifier for a team (see [Team.code])
  final String teamId;

  @override
  _TeamScheduleState createState() => _TeamScheduleState();
}

class _TeamScheduleState extends State<TeamScheduleView>
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder(
          future: loaded,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (snapshot.hasData) {
              return _build(context);
            }

            return Text('Loading...');
          },
        ),
      ),
    );
  }

  Future<void> _launchCall() async {
    final url = 'tel:${_team.coachTel}';
    if (await canLaunch(url)) {
      await launch(url);
    }
    //TODO: Fallback to popup phone number
  }

  Widget _build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        GFCard(
          title: GFListTile(
            titleText: 'Team ${_team?.code}',
            description: Text('Region ${_team.region.number} -'
                ' ${_team.division.getDisplayName()}'),
          ),
          content: Text('Coach ${_team?.coach ?? "To Be Determined"}'),
          buttonBar: GFButtonBar(
            children: [
              OutlineButton.icon(
                icon: Icon(_favorite ? Icons.star : Icons.star_border),
                label: Text(_favorite ? 'UnFavorite' : 'Favorite'),
                onPressed: updateFavorite,
              ),
              OutlineButton.icon(
                onPressed: _launchCall,
                icon: Icon(Icons.call),
                label: Text(_team?.coachTel ?? ''),
              ),
            ],
          ),
        ),
        //Other options:
        //- Table
        //- Expanded for each row
        //- Use ConstrainedBox (maybe with Flexible)
        ListView.builder(
          shrinkWrap: true,
          itemCount: _games?.length ?? 0,
          itemExtent: 32,
          itemBuilder: (_, index) => SingleTeamGameListTile(
            game: _games[index],
            teamId: _team?.code,
          ),
        ),
      ],
    );
  }
}
