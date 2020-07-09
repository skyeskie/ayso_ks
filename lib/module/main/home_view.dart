import 'package:ayso_ks/widgets/large_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatelessWidget {
  void _navigateSchedules() {}

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
              action: () {
                Navigator.pushNamed(context, '/schedules');
              }, //SchedulesMenu
            ),
            Spacer(),
            LargeIconButton(
              icon: Ionicons.md_map,
              label: Text('Region Info'),
              action: () {}, //RegionList
            ),
            Spacer(),
            LargeIconButton(
              icon: Ionicons.md_bookmark,
              label: Text('My Teams'),
              action: () {}, //FavoritesSchedule
            ),
            Spacer(),
            LargeIconButton(
              icon: Ionicons.logo_twitter,
              label: Text('Cancellations'),
              action: () {}, //TwitterView
            ),
            Spacer(),
            LargeIconButton(
              icon: Ionicons.md_settings,
              label: Text('Settings'),
              action: () {}, //Settings
            ),
            Spacer(
              flex: 10,
            ),
            LargeIconButton(
              icon: Icons.bug_report,
              label: Text('DEBUG'),
              action: () {
                Navigator.pushNamed(context, '/DEBUG');
              }, //Settings
            ),
          ],
        ),
      ),
    );
  }
}
