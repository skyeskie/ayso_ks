import 'package:flutter/material.dart';

import '../../routes_config.dart';
import '../../widgets/large_icon_button.dart';
import '../../widgets/nav_bar.dart';

class SchedulesMenuView extends StatelessWidget {
  SchedulesMenuView(this.regionNumber);

  final int regionNumber;

  @override
  Widget build(BuildContext context) {
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
                  ' Region $regionNumber',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.schedule,
              label: Text('This Week'),
              action: () => Routing.sailor('/schedules/week_current'),
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.search,
              label: Text('Find Team'),
              action: () => Routing.sailor('/search/teams'),
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.search,
              label: Text('Advanced Search'),
              action: () => Routing.sailor('/search'),
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.directions,
              label: Text('Directions'),
              action: () => Routing.sailor(
                '/region/map',
                params: {'regionNum': regionNumber},
              ),
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.map,
              label: Text('Field Map'),
              action: () => Routing.sailor(
                '/region/field',
                params: {'regionNum': regionNumber},
              ),
            ),
            Spacer(flex: 20),
          ],
        ),
      ),
    );
  }
}
