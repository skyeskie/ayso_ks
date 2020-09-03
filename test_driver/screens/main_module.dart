import 'package:flutter_driver/src/driver/driver.dart';
import 'package:flutter_driver_helper/flutter_driver_helper.dart';

class InitScreen extends BaseScreen {
  InitScreen(FlutterDriver driver) : super(driver);

  DWidget get formRegion => dWidget('regionDropdown');
  DWidget formRegionValue(int region) => dWidget('regionDropdown_$region');
  DWidget get formSubmit => dWidget('finishSubmit');
}

class HomeScreen extends BaseScreen {
  HomeScreen(FlutterDriver driver) : super(driver);

  DWidget get view => dWidget('HomeView');

  DWidget get schedules => dWidget('navSchedules');
  DWidget get region => dWidget('navRegion');
  DWidget get myTeams => dWidget('navFavorites');
  DWidget get cancellations => dWidget('navCancellations');
  DWidget get settings => dWidget('navSettings');
}

class SettingsScreen extends BaseScreen {
  SettingsScreen(FlutterDriver driver) : super(driver);

  DWidget get view => dWidget('SettingsView');
  DWidget get home => dWidget('navHome');
  DWidget formRegionValue(int region) => dWidget('regionRadio_$region');
}
