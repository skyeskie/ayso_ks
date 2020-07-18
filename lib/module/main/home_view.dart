import 'package:ayso_ks/dao/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

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
              icon: Ionicons.md_calendar,
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
              icon: Ionicons.md_map,
              label: Text('Region Info'),
              action: () => Routing.sailor('/region'),
            ),
            Spacer(),
            LargeIconButton(
              icon: Ionicons.md_bookmark,
              label: Text('My Teams'),
              action: () => Routing.sailor('/schedules/favorites'),
            ),
            Spacer(),
            LargeIconButton(
              icon: Ionicons.logo_twitter,
              label: Text('Cancellations'),
              action: () => Routing.sailor('/cancellations'),
            ),
            Spacer(),
            LargeIconButton(
              icon: Ionicons.md_settings,
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
