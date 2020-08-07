import 'package:flutter/material.dart';

/// Icon button across most of the width of the screen
///
/// Shows [icon] to the left of the main [label]
/// [action] is called onPressed
class LargeIconButton extends StatelessWidget {
  /// Create a button with [icon] and [label] with [action] callback on press
  const LargeIconButton({
    @required this.icon,
    @required this.label,
    @required this.action,
  });

  /// Icon to show - shortcut as [IconData] type
  ///
  /// Fed into [RaisedButton.icon] icon parameter after wrapped in an [Icon]
  final IconData icon;

  /// (text) label to show with the icon in the button
  ///
  /// Fed into [RaisedButton.icon] label parameter
  final Widget label;

  /// Callback function executed [RaisedButton.onPressed]
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
