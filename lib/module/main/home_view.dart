import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import '../../dao/settings.dart';
import '../../routes_config.dart';
import '../../widgets/large_icon_button.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 4),
            SvgPicture.asset(
              //TODO: Fix SVG (Only shows KS border, no other elements)
              'img/KansasSoccerBall.svg',
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
              semanticsLabel: 'Soccer Ball Logo',
            ),
            Image.asset(
              'img/HomeText.png',
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
              semanticLabel: 'AYSO Kansas',
            ),
            Spacer(flex: 2),
            LargeIconButton(
              icon: Icons.calendar_today,
              label: Text('Schedules'),
              action: () => GetIt.I.get<SettingsDAO>().getRegionNumber().then(
                    (value) => Routing.sailor(
                      '/schedules',
                      params: {'regionNum': value},
                    ),
                  ),
            ),
            Spacer(),
            LargeIconButton(
              icon: Icons.map,
              label: Text('Region Info'),
              action: () => Routing.sailor('/region'),
            ),
            Spacer(),
            LargeIconButton(
              icon: Icons.bookmark,
              label: Text('My Teams'),
              action: () => Routing.sailor('/schedules/favorites'),
            ),
            Spacer(),
            LargeIconButton(
              icon: Icons.rss_feed,
              label: Text('Cancellations'),
              action: () => Routing.sailor('/cancellations'),
            ),
            Spacer(),
            LargeIconButton(
              icon: Icons.settings,
              label: Text('Settings'),
              action: () => Routing.sailor('/settings'),
            ),
            Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }
}
