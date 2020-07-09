import 'package:flutter/material.dart';

import '../../models/game.dart';

class SingleTeamGameListTile extends StatelessWidget {
  final Game game;
  final String teamId;

  const SingleTeamGameListTile({
    @required this.game,
    @required this.teamId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(game.startTime.toString()),
          Text(game.home == teamId ? 'vs' : 'at'),
          Text(game.getOpponent(teamId)),
          Text('Region ${game.region}'),
          Text('Field ${game.field}'),
        ],
      ),
    );
  }
}
