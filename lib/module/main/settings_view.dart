import 'package:flutter/material.dart';

import '../../dao/backend.dart';
import '../../dao/settings.dart';
import '../../widgets/nav_bar.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with SettingsInjection {
  SettingsDataType _settings;
  void _updateSettings(SettingsDataType data) {
    setState(() {
      _settings = data;
    });
  }

  Future load;

  @override
  void initState() {
    load = settingsDAO.getSettingsReadonly().then(_updateSettings);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Settings', context),
      body: Text('Region: ${_settings?.regionNumber}'),
    );
  }
}
