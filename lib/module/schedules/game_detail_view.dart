import 'package:flutter/material.dart';

import '../../dao/games.dart';
import '../../models/game.dart';
import '../../util/date_format.dart';
import '../../widgets/nav_bar.dart';
import 'team_card.dart';

class GameDetailView extends StatefulWidget {
  const GameDetailView({Key key, this.id}) : super(key: key);

  final String id;

  @override
  _GameDetailViewState createState() => _GameDetailViewState();
}

class _GameDetailViewState extends State<GameDetailView> with GamesInjection {
  Future game;

  @override
  void initState() {
    game = gamesDAO.getGame(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Game Info', context),
      body: FutureBuilder(
        future: game,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _build(context, snapshot.data);
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
  Widget _build(BuildContext context, Game game) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Week #${game.weekNum} - ${game.startTime.toMediumString()}',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            TeamCard(team: game.home, type: VS.Home),
            TeamCard(team: game.away, type: VS.Away),
          ],
        ),
        SizedBox(height: 5),
        Text('Region ${game.region.number}'),
        RaisedButton.icon(
          onPressed: () => Navigator.of(context).pushNamed(
            '/region/${game.region.id}/map',
          ),
          icon: Icon(Icons.directions_car),
          label: Text('Directions'),
        ),
        Text('Field ${game.field}'),
        RaisedButton.icon(
          onPressed: () => Navigator.of(context).pushNamed(
            '/region/${game.region.id}/field',
          ),
          icon: Icon(Icons.map),
          label: Text('Field map'),
        ),
      ],
    );
  }
}
