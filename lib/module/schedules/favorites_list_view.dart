import 'package:flutter/material.dart';

import '../../dao/games.dart';
import '../../dao/settings.dart';
import '../../models/game.dart';
import '../../routes_config.dart';
import '../../widgets/nav_bar.dart';
import 'two_team_game_list.dart';

/// View showing whole-season schedule for saved teams
class FavoritesListView extends StatefulWidget {
  @override
  _FavoritesListViewState createState() => _FavoritesListViewState();
}

class _FavoritesListViewState extends State<FavoritesListView>
    with SettingsInjection, GamesInjection {
  List<String> myTeams = [];
  List<Game> myGames = [];
  Future loaded;

  @override
  void initState() {
    loaded = settingsDAO
        .getSavedTeamIDs()
        .then((itr) => myTeams = itr.toList(growable: false))
        .then((_) => gamesDAO.findForTeams(myTeams))
        .then((itr) => myGames = itr.toList(growable: false))
        .then((_) => 'done');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('My Teams', context),
      body: FutureBuilder(
        future: loaded,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == 'done') {
            if (myTeams.isNotEmpty) {
              return _build(context);
            }

            return Card(
              child: Column(
                children: [
                  Text('No saved teams'),
                  Divider(height: 10),
                  Text('Add some teams as favorites:'),
                  FlatButton(
                    child: Text('Find Team'),
                    onPressed: () => Routing.sailor('/search/teams'),
                  ),
                  Text('Click a team to view team page'),
                  Text('Click the star button in the top right'),
                ],
              ),
            );
          }

          if (snapshot.hasError || snapshot.hasData) {
            return Text(snapshot.error.toString());
          }

          return Text('Loading');
        },
      ),
    );
  }

  Widget _build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          itemCount: myTeams.length,
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            final team = myTeams.elementAt(index);
            return GridTile(
              child: OutlineButton(
                child: Text('Team $team'),
                onPressed: () => Routing.sailor(
                  '/schedules/team',
                  params: {'id': team},
                ),
              ),
            );
          },
        ),
        Divider(
          height: 20,
          thickness: 2,
        ),
        TwoTeamGameList(games: myGames),
      ],
    );
  }
}
