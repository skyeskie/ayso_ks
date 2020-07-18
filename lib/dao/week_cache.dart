import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class WeekCacheDAO {
  /// Get the number of weeks in a season
  int getMaxWeeks();

  /// Returns the current week, as determined by game days
  ///
  /// Week is determined by which week starts the game is between
  /// This should always be in the range `[1,maxWeeks]`
  int getCurrentWeek();

  /// Clears underlying data
  //TODO: Make sync?
  Future<void> clear();

  bool isInit();

  /// Initializes the cache
  Future init(Iterable<DateTime> starts);
}

mixin WeekCacheInjection<T extends StatefulWidget> on State<T> {
  final WeekCacheDAO weekCache = GetIt.I.get<WeekCacheDAO>();
}
