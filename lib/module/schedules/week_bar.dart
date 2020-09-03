import 'package:flutter/material.dart';

/// Header widget displaying the current week, with navigation to adjacent weeks
class WeekBar extends StatelessWidget {
  /// Construct for the current [week] with callback function [navigate].
  const WeekBar({
    Key key,
    @required this.week,
    @required this.maxWeeks,
    @required this.navigate,
  }) : super(key: key);

  /// Current week displayed
  final int week;

  /// Maximum number of weeks, for determining if to show next week button
  final int maxWeeks;

  /// Navigation callback function on week change
  ///
  /// The function takes the new week as the parameter
  final Function(int) navigate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(220, 220, 220, 1.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        leading: (week > 1)
            ? IconButton(
                key: ValueKey('navPrevWeek'),
                icon: Icon(Icons.arrow_back),
                onPressed: () => navigate(week - 1),
              )
            : const SizedBox(height: 48, width: 48),
        title: Align(
          child: Text(
            'Week #$week',
            textScaleFactor: 1.5,
          ),
        ),
        trailing: (week < maxWeeks)
            ? IconButton(
                key: ValueKey('navNextWeek'),
                icon: Icon(Icons.arrow_forward),
                onPressed: () => navigate(week + 1),
              )
            : const SizedBox(height: 48, width: 48),
      ),
    );
  }
}
