import 'dart:async';

import 'package:flutter/material.dart';

import '../../dao/games.dart';
import '../../dao/teams.dart';
import '../../models/game.dart';
import '../../models/team.dart';
import '../../util/date_format.dart';
import '../../widgets/nav_bar.dart';
import 'team_card.dart';

class GameDetailView extends StatefulWidget {
  const GameDetailView({Key key, this.id}) : super(key: key);

  final String id;

  @override
  _GameDetailViewState createState() => _GameDetailViewState();
}

class _GameDetailViewState extends State<GameDetailView>
    with GamesInjection, TeamsInjection {
  final _ready = Completer<String>();
  Game _game;
  Team _homeTeam;
  Team _awayTeam;

  @override
  void initState() {
    gamesDAO.getGame(widget.id).then((value) {
      _game = value;
      return Future.wait([
        teamsDAO.getTeam(value.home).then((team) => _homeTeam = team),
        teamsDAO.getTeam(value.away).then((team) => _awayTeam = team),
      ]).then((_) {
        _ready.complete('done');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Game Info', context),
      body: FutureBuilder(
        future: _ready.future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _build(context);
          }

          if (snapshot.hasError) {
            return SizedBox(
              height: 50,
              child: ListTile(
                title: Align(
                  child: Text('No games found'),
                ),
              ),
            );
          }

          return SizedBox(
            height: 50,
            child: ListTile(
              title: Align(
                child: Text('Loading...'),
              ),
            ),
          );
        },
      ),
    );
  }

  //TODO: Handle byes
  Widget _build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Week #${_game.weekNum} - ${_game.startTime.toMediumString()}',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            TeamCard(team: _homeTeam, type: VS.Home),
            TeamCard(team: _awayTeam, type: VS.Away),
          ],
        ),
        SizedBox(height: 5),
        Text('Region ${_game.region.number}'),
        RaisedButton.icon(
          onPressed: () => Navigator.of(context).pushNamed(
            '/region/${_game.region.id}/map',
          ),
          icon: Icon(Icons.directions_car),
          label: Text('Directions'),
        ),
        Text('Field ${_game.field}'),
        RaisedButton.icon(
          onPressed: () => Navigator.of(context).pushNamed(
            '/region/${_game.region.id}/field',
          ),
          icon: Icon(Icons.map),
          label: Text('Field map'),
        ),
      ],
    );
  }
}
