import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/game.dart';
import '../../util/date_format.dart';

class SingleTeamGameListTile extends StatelessWidget {
  const SingleTeamGameListTile({
    @required this.game,
    @required this.teamId,
  });

  final Game game;
  final String teamId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Modular.link.pushNamed('game/${game.id}'),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: Text(game.startTime.toMediumString())),
          Expanded(
            child: Text('${game.home.code == teamId ? "vs" : "at"} '
                '${game.getOpponent(teamId)}'),
          ),
          Expanded(child: Text('Region ${game.region.number}')),
          Expanded(child: Text('Field ${game.field}')),
        ],
      ),
    );
  }
}
