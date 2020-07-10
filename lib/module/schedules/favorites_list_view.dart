import 'package:flutter/material.dart';

import '../../dao/games.dart';
import '../../dao/settings.dart';

class FavoritesListView extends StatefulWidget {
  @override
  _FavoritesListViewState createState() => _FavoritesListViewState();
}

class _FavoritesListViewState extends State<FavoritesListView>
    with SettingsInjection, GamesInjection {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
