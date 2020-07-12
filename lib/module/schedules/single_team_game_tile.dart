import 'package:flutter/material.dart';

import '../../models/game.dart';

class SingleTeamGameListTile extends StatelessWidget {
  const SingleTeamGameListTile({
    @required this.game,
    @required this.teamId,
  });

  final Game game;
  final String teamId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Text(game.startTime.toString()),
          Text(game.home.code == teamId ? 'vs' : 'at'),
          Text(game.getOpponent(teamId)),
          Text('Region ${game.region}'),
          Text('Field ${game.field}'),
        ],
      ),
    );
  }
}
