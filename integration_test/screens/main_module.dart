import 'package:flutter_driver_helper/flutter_driver_helper.dart';

class InitScreen extends TestScreen {
  TestWidget get formRegion => tWidget('regionDropdown');
  TestWidget formRegionValue(int region) => tWidget('regionDropdown_$region');
  TestWidget get formSubmit => tWidget('finishSubmit');
}

class HomeScreen extends TestScreen {
  TestWidget get view => tWidget('HomeView');

  TestWidget get schedules => tWidget('navSchedules');
  TestWidget get region => tWidget('navRegion');
  TestWidget get myTeams => tWidget('navFavorites');
  TestWidget get cancellations => tWidget('navCancellations');
  TestWidget get settings => tWidget('navSettings');
}

class SettingsScreen extends TestScreen {
  TestWidget get view => tWidget('SettingsView');
  TestWidget get home => tWidget('navHome');
  TestWidget formRegionValue(int region) => tWidget('regionRadio_$region');
}

class CancellationsScreen extends TestScreen {
  TestWidget get view => tWidget('CancellationsView');
  TestWidget get home => tWidget('navHome');

  TestWidget get timeline => tWidget('TwitterTimeline');
}
