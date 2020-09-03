import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_driver_helper/flutter_driver_helper.dart';
import 'package:test/test.dart';

import 'driver_actions.dart';
import 'isolates_workaround.dart';
import 'main_screens.dart';
import 'region_screens.dart';
import 'schedules_screens.dart';
import 'screencam.dart';

void main() {
  group('AYSO App', () {
    FlutterDriver driver;
    IsolatesWorkaround isoWork;
    Screenshoter screen;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      isoWork = IsolatesWorkaround(driver);
      screen = Screencam(driver, './build/screenshots');
      await isoWork.resumeIsolates();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
        await isoWork.tearDown();
      }
    });

    test('check flutter driver health', () async {
      final health = await driver.checkHealth();
      print(health.status);
    });

    test('fill init form', () async {
      final initScreen = InitScreen(driver);
      final homeScreen = HomeScreen(driver);

      await runTestActions([
        initScreen.formRegion.waitFor(),
        initScreen.formRegion.tap(),
        initScreen.formRegionValue(49).waitFor(),
        initScreen.formRegionValue(49).tap(),
        screen.screenshot('Initial configuration'),
        initScreen.formSubmit.tap(),
        homeScreen.view.waitFor(),
        screen.screenshot('Home screen'),
      ]);
    });

    test('view previous week schedule', () async {
      final homeScreen = HomeScreen(driver);
      final scheduleMenuScreen = SchedulesMenuScreen(driver);
      final weekSchedulesScreen = WeekScheduleScreen(driver);

      await runTestActions([
        homeScreen.schedules.tap(),
        scheduleMenuScreen.view.waitFor(),
        screen.screenshot('Schedules menu'),
        CommonTestActions.findText(driver, 'Region 49'),
        scheduleMenuScreen.week.tap(),
        CommonTestActions.findText(driver, 'Week #8'),
        weekSchedulesScreen.prevWeek.tap(),
        CommonTestActions.findText(driver, 'Week #7'),
        screen.screenshot('Current week schedule'),
      ]);
    });

    test('view game info', () async {
      final homeScreen = HomeScreen(driver);
      final gameScreen = GameDetailScreen(driver);

      await runTestActions([
        CommonTestActions.tapText(driver, '1702B vs 1706B'),
        gameScreen.view.waitFor(),
        screen.screenshot('Game detail'),
        CommonTestActions.findText(driver, 'Oct 31, 12:15'),
        CommonTestActions.findText(driver, 'Home Team'),
        CommonTestActions.findText(driver, 'Away Team'),
        gameScreen.home.tap(),
        homeScreen.view.waitFor(),
      ]);
    });

    test('view region info', () async {
      final homeScreen = HomeScreen(driver);
      final regionListScreen = RegionListScreen(driver);
      final streetMapScreen = StreetMapScreen(driver);
      final fieldMapScreen = FieldScreen(driver);

      await runTestActions([
        homeScreen.region.tap(),
        regionListScreen.view.waitFor(),
        screen.screenshot('Region list'),
        regionListScreen.roadMap(105).tap(),
        streetMapScreen.view.waitFor(),
        CommonTestActions.findText(driver, 'Region 105'),
        streetMapScreen.pageBack.tap(),
        regionListScreen.view.waitFor(),
        regionListScreen.fieldMap(253).tap(),
        fieldMapScreen.view.waitFor(),
        CommonTestActions.findText(driver, 'Region 253 Fields'),
        fieldMapScreen.home.tap(),
        homeScreen.view.waitFor(),
      ]);
    });

    test('set favorite teams and view favorites', () async {}, skip: 'TODO');
    test('search for games', () async {}, skip: 'TODO');

    test('change region and verify', () async {
      final homeScreen = HomeScreen(driver);
      final scheduleMenuScreen = SchedulesMenuScreen(driver);
      final settingsScreen = SettingsScreen(driver);

      await runTestActions([
        homeScreen.settings.tap(),
        settingsScreen.view.waitFor(),
        settingsScreen.formRegionValue(208).tap(),
        screen.screenshot('Settings'),
        settingsScreen.pageBack.tap(),
        homeScreen.view.waitFor(),
        homeScreen.schedules.tap(),
        scheduleMenuScreen.view.waitFor(),
        CommonTestActions.findText(driver, 'Region 208'),
        scheduleMenuScreen.pageBack.tap(),
        homeScreen.view.waitFor(),
      ]);
    });
  });
  test('remove team from favorites', () async {}, skip: 'TODO');

  test('reset app - delete favorites', () async {}, skip: 'TODO');
}
