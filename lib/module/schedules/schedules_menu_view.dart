import 'package:ayso_ks/widgets/large_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';

class SchedulesMenuView extends StatelessWidget {
  /// Region number
  final int region;

  const SchedulesMenuView({
    this.region = 49,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Region $region'),
      ),
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
                  ' Region $region',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            Spacer(flex: 2),
            GFButton(
              icon: Icon(Icons.schedule),
              text: "This Week",
              type: GFButtonType.solid,
              onPressed: () => {},
              size: GFSize.LARGE,
              blockButton: true,
            ),
            LargeIconButton(
              icon: Icons.schedule,
              label: Text('This Week'),
              action: () => {},
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.search,
              label: Text('Find Team'),
              action: () => {},
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.search,
              label: Text('Advanced Search'),
              action: () => {},
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.directions,
              label: Text('Directions'),
              action: () => {},
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.map,
              label: Text('Field Map'),
              action: () => {},
            ),
            Spacer(flex: 20),
          ],
        ),
      ),
    );
  }
}
