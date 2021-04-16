import 'package:flutter_driver_helper/flutter_driver_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';

import 'app.dart' as app_test;
import 'screens/main_module.dart';
import 'screens/region_module.dart';
import 'screens/schedules_module.dart';
import 'screens/search_module.dart';
import 'util/driver_actions.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('AYSO App', () {
    final screen = Screenshoter(0, './build/screenshots', enabled: false);

    final initScreen = InitScreen();
    final homeScreen = HomeScreen();
    final scheduleMenuScreen = SchedulesMenuScreen();
    final weekSchedulesScreen = WeekScheduleScreen();
    final gameScreen = GameDetailScreen();
    final regionListScreen = RegionListScreen();
    final streetMapScreen = StreetMapScreen();
    final fieldMapScreen = FieldScreen();
    final favoritesScreen = FavoritesListScreen();
    final teamSelectScreen = TeamSelectScreen();
    final teamScheduleScreen = TeamScheduleScreen();
    final schedulesMenuScreen = SchedulesMenuScreen();
    final searchScreen = SearchScreen();
    final searchResultsScreen = SearchResultsScreen();
    final cancelScreen = CancellationsScreen();
    final settingsScreen = SettingsScreen();
    const lastTweetCreated = '07:01 • 04.22.2017';

    setUpAll(() async {
      //Put in options for screenshots
      // screen = Screencam(driver, './build/screenshots', enabled: false);
    });

    tearDown(() async {
      GetIt.I.reset();
    });

    IntegrationTestRun('fill init form', app_test.main, actions: [
      initScreen.formRegion.waitFor(),
      initScreen.formRegion.tap(),
      initScreen.formRegionValue(49).waitFor(),
      initScreen.formRegionValue(49).tap(),
      screen.screenshot('Initial configuration'),
      initScreen.formSubmit.tap(),
      homeScreen.view.waitFor(),
      screen.screenshot('Home screen'),
    ]).run();

    IntegrationTestRun('view previous week schedule', app_test.main, actions: [
        homeScreen.schedules.tap(),
        scheduleMenuScreen.view.waitFor(),
        screen.screenshot('Schedules menu'),
        CommonTestActions.findText('Region 49'),
        scheduleMenuScreen.week.tap(),
        CommonTestActions.findText('Week #8'),
        weekSchedulesScreen.prevWeek.tap(),
        CommonTestActions.findText('Week #7'),
        screen.screenshot('Current week schedule'),
      ]).run();

    IntegrationTestRun('view game info', app_test.main, actions: [
      homeScreen.schedules.tap(),
      scheduleMenuScreen.view.waitFor(),
      scheduleMenuScreen.week.tap(),
      weekSchedulesScreen.prevWeek.tap(),
        CommonTestActions.tapText('1702B vs 1706B'),
        gameScreen.view.waitFor(),
        screen.screenshot('Game detail'),
        CommonTestActions.findText('Oct 31, 12:15'),
        CommonTestActions.findText('Home Team'),
        CommonTestActions.findText('Away Team'),
        gameScreen.home.tap(),
        homeScreen.view.waitFor(),
      ]).run();

    IntegrationTestRun('view region info', app_test.main, actions: [
        homeScreen.region.tap(),
        regionListScreen.view.waitFor(),
        screen.screenshot('Region list'),
        regionListScreen.roadMap(105).tap(),
        streetMapScreen.view.waitFor(),
        CommonTestActions.findText('Region 105'),
        screen.screenshot('Road map'),
        streetMapScreen.pageBack.tap(),
        regionListScreen.view.waitFor(),
        regionListScreen.fieldMap(253).tap(),
        fieldMapScreen.view.waitFor(),
        CommonTestActions.findText('Region 253 Fields'),
        screen.screenshot('Field map'),
        fieldMapScreen.home.tap(),
        homeScreen.view.waitFor(),
      ]).run('fieldMap 253 throws error');

    IntegrationTestRun('set favorite team from blank favorites',
            app_test.main, actions: [
        homeScreen.myTeams.tap(),
        favoritesScreen.view.waitFor(),
        favoritesScreen.findTeam.waitFor(),
        screen.screenshot('Favorites empty'),
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
        screen.screenshot('Team schedule'),
        CommonTestActions.findText('Team 252B'),
        CommonTestActions.findText('Favorite'),
        teamScheduleScreen.favoriteToggle.tap(),
        CommonTestActions.findText('UnFavorite'),
        teamScheduleScreen.pageBack.tap(),
        teamSelectScreen.view.waitFor(),
        teamSelectScreen.pageBack.tap(),
        favoritesScreen.view.waitFor(),
        favoritesScreen.findTeam.waitForAbsent(),
        favoritesScreen.pageBack.tap(),
        homeScreen.view.waitFor(),
      ]).run();

    IntegrationTestRun('set favorite team from search',
            app_test.main, actions: [
        homeScreen.schedules.tap(),
        schedulesMenuScreen.view.waitFor(),
        schedulesMenuScreen.teamSelect.tap(),
        teamSelectScreen.view.waitFor(),
        //ERROR
        teamSelectScreen.resultTeam('1601G').scrollUntilVisible(
            -150, scrollable: teamSelectScreen.results.finderSingle
        ),
        teamSelectScreen.resultTeam('1601G').tap(),
        teamScheduleScreen.view.waitFor(),
        teamScheduleScreen.favoriteToggle.tap(),
        teamScheduleScreen.home.tap(),
        homeScreen.view.waitFor(),
      ]).run('scrollUntilVisible not working');

    IntegrationTestRun('view favorite teams', app_test.main, actions: [
        homeScreen.myTeams.tap(),
        favoritesScreen.view.waitFor(),
        favoritesScreen.findTeam.waitForAbsent(),
        favoritesScreen.favoriteTeam('252B').waitFor(),
        screen.screenshot('Favorites schedule'),
        CommonTestActions.findText('1603G vs 1601G'),
        favoritesScreen.pageBack.tap(),
        homeScreen.view.waitFor(),
      ]).run('depends on "set favorite team" test');

    IntegrationTestRun('search for games', app_test.main, actions: [
        homeScreen.schedules.tap(),
        schedulesMenuScreen.view.waitFor(),
        schedulesMenuScreen.search.tap(),
        searchScreen.view.waitFor(),
        searchScreen.regionDropdown.tap(),
        searchScreen.regionOption(105).tap(),
        searchScreen.ageDropdown.tap(),
        screen.screenshot('Advanced search'),
        searchScreen.ageOption(8).tap(),
        searchScreen.submit.tap(),
        searchResultsScreen.view.waitFor(),
        CommonTestActions.findText('Region 105'),
        CommonTestActions.findText('Age U8'),
        CommonTestActions.findText('261B vs 565B'),
        searchResultsScreen.nextWeek.tap(),
        searchResultsScreen.prevWeek.waitFor(),
        screen.screenshot('Search results'),
        CommonTestActions.findText('261B vs 262B'),
        searchResultsScreen.pageBack.tap(),
        searchScreen.view.waitFor(),
        searchScreen.home.tap(),
        homeScreen.view.waitFor(),
      ]).run();

    IntegrationTestRun('change region and verify', app_test.main, actions: [
        homeScreen.settings.tap(),
        settingsScreen.view.waitFor(),
        settingsScreen.formRegionValue(208).tap(),
        screen.screenshot('Settings'),
        settingsScreen.pageBack.tap(),
        homeScreen.view.waitFor(),
        homeScreen.schedules.tap(),
        scheduleMenuScreen.view.waitFor(),
        CommonTestActions.findText('Region 208'),
        scheduleMenuScreen.pageBack.tap(),
        homeScreen.view.waitFor(),
      ]).run();

    // 'All games at AYSO Region 49 for April 22 have been '
    // 'cancelled because of wet fields.';

    IntegrationTestRun('View cancellations', app_test.main, actions: [
        homeScreen.cancellations.tap(),
        cancelScreen.view.waitFor(),
        CommonTestActions.scrollForText(
          cancelScreen.timeline.finderSingle,
          lastTweetCreated,
          amount: 500,
        ),
        cancelScreen.home.tap(),
        homeScreen.view.waitFor(),
      ]).run('need to redo scroll');

    IntegrationTestRun('remove team from favorites', app_test.main, actions: [
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
      ]).run();

    IntegrationTestRun('reset app - delete favorites', app_test.main, actions: [
      ]).run('TODO');
  });
}
