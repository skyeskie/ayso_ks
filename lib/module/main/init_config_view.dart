import 'package:flutter/material.dart';

import '../../dao/settings.dart';

//Maybe convert to popup in guard
class InitConfigView extends StatefulWidget {
  @override
  _InitConfigViewState createState() => _InitConfigViewState();
}

class _InitConfigViewState extends State<InitConfigView>
    with SettingsInjection {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Init'),
      ),
    );
  }
}
