import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// Interface for accessing Week Cache
///
/// This is intended for fast, synchronous access to common functions that
/// could be computationally intensive. (Figuring out week starts from scratch,
/// for example, would require iterating over all games)
abstract class WeekCacheDAO {
  /// Get the number of weeks in a season
  int getMaxWeeks();

  /// Returns the current week, as determined by game days
  ///
  /// Week is determined by which week starts the game is between
  /// This should always be in the range `[1,maxWeeks]`
  int getCurrentWeek();

  /// Clears underlying data
  Future<void> clear();

  /// Returns true iff this is initialized with week starts
  bool isInit();

  /// Initializes the cache
  Future init(Iterable<DateTime> starts);
}

mixin WeekCacheInjection<T extends StatefulWidget> on State<T> {
  /// Access for week cache
  final WeekCacheDAO weekCache = GetIt.I.get<WeekCacheDAO>();
}
