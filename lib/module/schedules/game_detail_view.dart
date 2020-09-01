import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../dao/games.dart';
import '../../dao/teams.dart';
import '../../models/game.dart';
import '../../models/team.dart';
import '../../routes_config.dart';
import '../../util/date_format.dart';
import '../../widgets/nav_bar.dart';
import 'team_card.dart';

/// View showing details for a single game
class GameDetailView extends StatefulWidget {
  /// Constructor
  const GameDetailView({Key key, this.id}) : super(key: key);

  /// Game unique identified used for retrieving the game
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
      if (value == null) {
        return _ready.completeError(ArgumentError());
      }

      _game = value;
      final teamCalls = <Future>[];

      if (value.home == Game.BYE_TEAM) {
        _homeTeam = Team.bye();
      } else {
        teamCalls.add(
          teamsDAO.getTeam(value.home).then((team) => _homeTeam = team),
        );
      }

      if (value.away == Game.BYE_TEAM) {
        _awayTeam = Team.bye();
      } else {
        teamCalls.add(
          teamsDAO.getTeam(value.away).then((team) => _awayTeam = team),
        );
      }

      Future.wait(teamCalls).then((_) {
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

  Widget _build(BuildContext context) {
    final haveHomeTeam = _homeTeam.code != Game.BYE_TEAM;
    final haveAwayTeam = _awayTeam.code != Game.BYE_TEAM;
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        Text(
          'Week #${_game.weekNum}',
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          '${_game.startTime?.toMediumString() ?? ""}',
          style: Theme.of(context).textTheme.headline5,
        ),
        if (_game.isBye()) Spacer(),
        if (_game.isBye())
          Text(
            'BYE',
            style: Theme.of(context).textTheme.headline4,
          ),
        Spacer(),
        if (haveHomeTeam)
          TeamCard(
            team: _homeTeam,
            type: haveAwayTeam ? VS.Home : VS.Ignore,
          ),
        if (haveHomeTeam) Spacer(),
        if (haveAwayTeam)
          TeamCard(
            team: _awayTeam,
            type: haveHomeTeam ? VS.Away : VS.Ignore,
          ),
        if (haveAwayTeam) Spacer(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 4,
              child: Text(
                'Region ${_game.region.number}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              flex: 4,
              child: GFButton(
                onPressed: () => Routing.sailor(
                  '/region/map',
                  params: {'regionNum': _game.region.number},
                ),
                icon: Icon(Icons.directions_car),
                child: Text('Directions'),
              ),
            ),
            Spacer(),
          ],
        ),
        Spacer(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 4,
              child: Text(
                'Field ${_game.field}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              flex: 4,
              child: GFButton(
                onPressed: () => Routing.sailor(
                  '/region/field',
                  params: {'regionNum': _game.region.number},
                ),
                icon: Icon(Icons.map),
                child: Text('Field Map'),
              ),
            ),
            Spacer(),
          ],
        ),
        Spacer(flex: 5),
      ],
    );
  }
}
