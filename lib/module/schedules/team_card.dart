import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../models/team.dart';

enum VS {
  Home,
  Away,
  Ignore,
}

class TeamCard extends StatelessWidget {
  TeamCard({Key key, this.team, VS type})
      : teamLabel = formatVS(type),
        super(key: key);

  final Team team;
  final String teamLabel;

  @override
  Widget build(BuildContext context) {
    return GFCard(
      title: GFListTile(
        titleText: teamLabel,
        subtitleText: team.code,
        description: Row(
          children: [Text('Coach: '), Text('${team.coach}')],
        ),
        icon: GFButton(
          icon: Icon(Icons.call),
          child: Text('Call'),
          onPressed: () {},
        ),
      ),
    );
  }

  static String formatVS(VS vs) {
    switch (vs) {
      case VS.Home:
        return 'Home Team';
      case VS.Away:
        return 'Away Team';
      case VS.Ignore:
    }
    return 'Team';
  }
}
