import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/team.dart';

/// Enum for determining which type of team is being displayed
enum VS {
  /// This is for the home team, displayed along with an away team
  Home,

  /// This is for the away team, displayed along with the home team
  Away,

  /// This is for displaying a single team (ie in a bye)
  Ignore,
}

/// Card widget showing information for a team
class TeamCard extends StatelessWidget {
  /// Create a card for the [team] model according to its [type]
  TeamCard({Key key, this.team, VS type})
      : teamLabel = formatVS(type),
        super(key: key);

  /// Team information to display
  final Team team;

  /// Title of the card, determined based on the [VS] type
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
        icon: GFIconButton(
          icon: Icon(Icons.call),
          onPressed: _launchCall,
          shape: GFIconButtonShape.circle,
        ),
      ),
    );
  }

  Future<void> _launchCall() async {
    final url = 'tel:${team.coachTel}';
    if (await canLaunch(url)) {
      await launch(url);
    }
    //TODO: Fallback to popup phone number
  }

  /// Auxiliary function to convert the [VS] type to [teamLabel] string
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
