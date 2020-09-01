import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../dao/settings.dart';
import '../../routes_config.dart';
import '../../widgets/large_icon_button.dart';

/// Home menu view - initial displayed view for the app
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                'img/MainLogo.png',
                alignment: Alignment.bottomCenter,
                fit: BoxFit.fitWidth,
                semanticLabel: 'AYSO Kansas',
              ),
            ),
            Divider(),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LargeIconButton(
                    icon: Icons.calendar_today,
                    label: Text('Schedules'),
                    action: _navSchedules,
                  ),
                  LargeIconButton(
                    icon: Icons.map,
                    label: Text('Region Info'),
                    action: () => Routing.sailor('/region'),
                  ),
                  LargeIconButton(
                    icon: Icons.bookmark,
                    label: Text('My Teams'),
                    action: () => Routing.sailor('/schedules/favorites'),
                  ),
                  LargeIconButton(
                    icon: Icons.rss_feed,
                    label: Text('Cancellations'),
                    action: () => Routing.sailor('/cancellations'),
                  ),
                  LargeIconButton(
                    icon: Icons.settings,
                    label: Text('Settings'),
                    action: () => Routing.sailor('/settings'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navSchedules() {
    GetIt.I.get<SettingsDAO>().getRegionNumber().then(
          (value) => Routing.sailor(
            '/schedules',
            params: {'regionNum': value},
          ),
        );
  }
}
