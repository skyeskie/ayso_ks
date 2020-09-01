import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../routes_config.dart';
import '../../util/date_format.dart';

/// Widget ListTile showing a single game for use in a single-team listing
class SingleTeamGameListTile extends StatelessWidget {
  /// Constant constructor
  const SingleTeamGameListTile({
    @required this.game,
    @required this.teamId,
  });

  /// Game information for display
  final Game game;

  /// Team ID for the team that the listing is for
  ///
  /// This is used for finding the opponent and vs/at display
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
          Expanded(child: Text(game.startTime.toMediumString()), flex: 3),
          if (game.isBye()) Expanded(child: Text('BYE'), flex: 2),
          if (!game.isBye())
            Expanded(
              flex: 2,
              child: Text('${game.home == teamId ? "vs" : "at"} '
                  '${game.getOpponent(teamId)}'),
            ),
          Expanded(child: Text('Region ${game.region.number}'), flex: 2),
          Expanded(child: Text('Field ${game.field}'), flex: 2),
        ],
      ),
    );
  }
}
