import 'package:flutter/material.dart';

import '../../dao/games.dart';
import '../../dao/week_cache.dart';

class WeekScheduleView extends StatefulWidget {
  @override
  _WeekScheduleViewState createState() => _WeekScheduleViewState();
}

class _WeekScheduleViewState extends State<WeekScheduleView>
    with GamesInjection, WeekCacheInjection {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WeekScheduleView'),
      ),
    );
  }
}
