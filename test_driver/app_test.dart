import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_driver_helper/flutter_driver_helper.dart';
import 'package:test/test.dart';

import 'screens/main_module.dart';
import 'screens/region_module.dart';
import 'screens/schedules_module.dart';
import 'screens/search_module.dart';
import 'util/driver_actions.dart';
import 'util/isolates_workaround.dart';
import 'util/screencam.dart';

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

    test('set favorite team from blank favorites', () async {
      final homeScreen = HomeScreen(driver);
      final favoritesScreen = FavoritesListScreen(driver);
      final teamSelectScreen = TeamSelectScreen(driver);
      final teamScheduleScreen = TeamScheduleScreen(driver);

      await runTestActions([
        homeScreen.myTeams.tap(),
        favoritesScreen.view.waitFor(),
        favoritesScreen.findTeam.waitFor(),
        favoritesScreen.findTeam.tap(),
        teamSelectScreen.view.waitFor(),
        teamSelectScreen.regionOption(105).tap(),
        teamSelectScreen.resultTeam('1701B').waitForAbsent(),
        teamSelectScreen.ageGroupOption(10).tap(),
        teamSelectScreen.resultTeam('241B').waitForAbsent(),
        teamSelectScreen.genderOption('B').tap(),
        teamSelectScreen.resultTeam('251G').waitForAbsent(),
        teamSelectScreen.resultTeam('252B').waitFor(),
        teamSelectScreen.resultTeam('252B').tap(),
        teamScheduleScreen.view.waitFor(),
        CommonTestActions.findText(driver, 'Team 252B'),
        CommonTestActions.findText(driver, 'Favorite'),
        teamScheduleScreen.favoriteToggle.tap(),
        CommonTestActions.findText(driver, 'UnFavorite'),
        //TODO: Verify present on POP
        teamScheduleScreen.home.tap(),
        homeScreen.view.waitFor(),
      ]);
    });

    test('set favorite team from search', () async {
      final homeScreen = HomeScreen(driver);
      final teamSelectScreen = TeamSelectScreen(driver);
      final teamScheduleScreen = TeamScheduleScreen(driver);
      final schedulesMenuScreen = SchedulesMenuScreen(driver);

      await runTestActions([
        homeScreen.schedules.tap(),
        schedulesMenuScreen.view.waitFor(),
        schedulesMenuScreen.teamSelect.tap(),
        teamSelectScreen.view.waitFor(),
        teamSelectScreen.resultTeam('1601G').scrollUntilVisible(dyScroll: -150),
        teamSelectScreen.resultTeam('1601G').tap(),
        teamScheduleScreen.view.waitFor(),
        teamScheduleScreen.favoriteToggle.tap(),
        teamScheduleScreen.home.tap(),
        homeScreen.view.waitFor(),
      ]);
    });

    test('view favorite teams', () async {
      final homeScreen = HomeScreen(driver);
      final favoritesScreen = FavoritesListScreen(driver);

      await runTestActions([
        homeScreen.myTeams.tap(),
        favoritesScreen.view.waitFor(),
        favoritesScreen.findTeam.waitForAbsent(),
        favoritesScreen.favoriteTeam('252B').waitFor(),
        CommonTestActions.findText(driver, '1603G vs 1601G'),
        favoritesScreen.pageBack.tap(),
        homeScreen.view.waitFor(),
      ]);
    });

    test('search for games', () async {
      final homeScreen = HomeScreen(driver);
      final schedulesMenuScreen = SchedulesMenuScreen(driver);
      final searchScreen = SearchScreen(driver);
      final searchResultsScreen = SearchResultsScreen(driver);

      await runTestActions([
        homeScreen.schedules.tap(),
        schedulesMenuScreen.view.waitFor(),
        schedulesMenuScreen.search.tap(),
        searchScreen.view.waitFor(),
        searchScreen.regionDropdown.tap(),
        searchScreen.regionOption(105).tap(),
        searchScreen.ageDropdown.tap(),
        searchScreen.ageOption(8).tap(),
        searchScreen.submit.tap(),
        searchResultsScreen.view.waitFor(),
        CommonTestActions.findText(driver, 'Region 105'),
        CommonTestActions.findText(driver, 'Age U8'),
        CommonTestActions.findText(driver, '261B vs 565B'),
        searchResultsScreen.nextWeek.tap(),
        searchResultsScreen.prevWeek.waitFor(),
        CommonTestActions.findText(driver, '261B vs 262B'),
        searchResultsScreen.pageBack.tap(),
        searchScreen.view.waitFor(),
        searchScreen.home.tap(),
        homeScreen.view.waitFor(),
      ]);
    });

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

    test('remove team from favorites', () async {
      final homeScreen = HomeScreen(driver);
      final favoritesScreen = FavoritesListScreen(driver);
      final teamScheduleScreen = TeamScheduleScreen(driver);

      await runTestActions([
        homeScreen.myTeams.tap(),
        favoritesScreen.view.waitFor(),
        favoritesScreen.findTeam.waitForAbsent(),
        favoritesScreen.favoriteTeam('252B').tap(),
        teamScheduleScreen.view.waitFor(),
        teamScheduleScreen.favoriteToggle.tap(),
        teamScheduleScreen.pageBack.tap(),
        favoritesScreen.view.waitFor(),
        favoritesScreen.findTeam.waitForAbsent(),
        favoritesScreen.favoriteTeam('252B').waitForAbsent(),
        favoritesScreen.pageBack.tap(),
        homeScreen.view.waitFor(),
      ]);
    }, skip: 'TODO: Does not refresh on page back!');

    test('reset app - delete favorites', () async {}, skip: 'TODO');
  });
}
