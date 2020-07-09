import 'package:flutter/material.dart';

/// Icon button across most of the width of the screen
///
/// Shows [icon] to the left of the main [label]
/// [action] is called onPressed
class LargeIconButton extends StatelessWidget {
  const LargeIconButton({
    @required this.icon,
    @required this.label,
    @required this.action,
  });

  final IconData icon;
  final Widget label;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.center,
      widthFactor: .8,
      child: RaisedButton.icon(
        icon: Icon(icon),
        label: label,
        onPressed: action, //SchedulesMenu
        padding: EdgeInsets.symmetric(
          vertical: 15,
        ),
      ),
    );
  }
}
