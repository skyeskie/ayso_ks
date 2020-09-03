import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_driver_helper/flutter_driver_helper.dart';
import 'package:test/test.dart';

import 'driver_actions.dart';
import 'isolates_workaround.dart';
import 'main_screens.dart';
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
        weekSchedulesScreen.home.tap(),
        homeScreen.view.waitFor(),
      ]);
    });

    test('view game info', () async {}, skip: 'TODO');
    test('view region info', () async {}, skip: 'TODO');
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
