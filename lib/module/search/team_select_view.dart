import 'package:flutter/material.dart';

import '../../dao/teams.dart';
import '../../widgets/nav_bar.dart';

class TeamSelectView extends StatefulWidget {
  @override
  _TeamSelectViewState createState() => _TeamSelectViewState();
}

class _TeamSelectViewState extends State<TeamSelectView> with TeamsInjection {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Select Team', context),
    );
  }
}
