import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../dao/settings.dart';
import '../../widgets/large_icon_button.dart';
import '../../widgets/nav_bar.dart';

class SchedulesMenuView extends StatelessWidget {
  SchedulesMenuView();

  @override
  Widget build(BuildContext context) {
    final settings = Modular.get<SettingsDataType>();
    final regionNumber = settings.regionNumber;

    final theme = Theme.of(context);
    return Scaffold(
      appBar: buildNavBar('Region $regionNumber', context),
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'img/HomeText.png',
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
              semanticLabel: 'AYSO Kansas',
            ),
            Spacer(flex: 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Schedules ',
                  style: theme.textTheme.headline4.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' Region ${settings.regionNumber}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.schedule,
              label: Text('This Week'),
              action: () => Navigator.pushNamed(context, '/schedules/week'),
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.search,
              label: Text('Find Team'),
              action: () => Navigator.pushNamed(context, '/search/teams'),
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.search,
              label: Text('Advanced Search'),
              action: () => Navigator.pushNamed(context, '/search'),
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.directions,
              label: Text('Directions'),
              action: () =>
                  Navigator.pushNamed(context, '/region/$regionNumber/map'),
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.map,
              label: Text('Field Map'),
              action: () =>
                  Navigator.pushNamed(context, '/region/$regionNumber/field'),
            ),
            Spacer(flex: 20),
          ],
        ),
      ),
    );
  }
}
