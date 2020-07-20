import 'package:flutter/material.dart';

class WeekBar extends StatelessWidget {
  const WeekBar({
    Key key,
    @required this.week,
    @required this.maxWeeks,
    @required this.navigate,
  }) : super(key: key);

  final int week;
  final int maxWeeks;
  final Function(int) navigate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(220, 220, 220, 1.0),
      child: ListTile(
        leading: (week > 1)
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => navigate(week - 1),
              )
            : const SizedBox(height: 48, width: 48),
        title: Align(
          child: Text('Week #$week'),
        ),
        trailing: (week < maxWeeks)
            ? IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => navigate(week + 1),
              )
            : const SizedBox(height: 48, width: 48),
      ),
    );
  }
}
