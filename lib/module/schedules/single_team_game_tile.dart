import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../routes_config.dart';
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
      onTap: () => Routing.sailor(
        '/schedules/game',
        params: {'id': game.id},
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: Text(game.startTime.toMediumString())),
          if (game.isBye()) Expanded(child: Text('BYE')),
          if (!game.isBye())
            Expanded(
              child: Text('${game.home == teamId ? "vs" : "at"} '
                  '${game.getOpponent(teamId)}'),
            ),
          Expanded(child: Text('Region ${game.region.number}')),
          Expanded(child: Text('Field ${game.field}')),
        ],
      ),
    );
  }
}
