import 'package:flutter/material.dart';

import '../../models/team.dart';
import '../../widgets/large_icon_button.dart';

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
    return Expanded(
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$teamLabel Team'),
            Text('${team.code}'),
            Row(
              children: [Text('Coach'), Text('${team.coach}')],
            ),
            LargeIconButton(
              icon: Icons.call,
              label: const Text('Call'),
              action: () {},
            )
          ],
        ),
      ),
    );
  }

  static String formatVS(VS vs) {
    switch (vs) {
      case VS.Home:
        return 'Home';
      case VS.Away:
        return 'Away';
      case VS.Ignore:
    }
    return '';
  }
}
