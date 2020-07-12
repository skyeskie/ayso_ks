import 'package:flutter/material.dart';

import '../../dao/backend.dart';
import '../../dao/settings.dart';
import '../../models/region.dart';
import '../../widgets/nav_bar.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with SettingsInjection {
  SettingsDataType _settings;
  bool _troubleshootExpanded = false;

  @override
  void initState() {
    _updateSettings();
    super.initState();
  }

  void _updateSettings() {
    settingsDAO.getSettingsReadonly().then(_setSettingsState);
  }

  void _setSettingsState(SettingsDataType data) {
    setState(() {
      _settings = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Settings', context),
      body: _settings == null ? _buildLoading(context) : _build(context),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Text('Loading');
  }

  Widget _build(BuildContext context) {
    return Column(
      children: [
        Text('Home Region', style: Theme.of(context).textTheme.headline5),
        Text('This filters your current week view and other parts of the app'),
        DropdownButton(
          value: _settings.regionNumber,
          onChanged: (regionNum) =>
              settingsDAO.setRegion(regionNum).then((_) => _updateSettings()),
          items: Region.REGIONS
              .map((r) => DropdownMenuItem(
                    value: r.number,
                    child: Text('Region ${r.number} (${r.name})'),
                  ))
              .toList(growable: false),
        ),
        Divider(height: 30),
        ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) =>
              setState(() => {_troubleshootExpanded = !isExpanded}),
          children: [
            ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                if (isExpanded) {
                  return Text('Troubleshooting');
                }

                return Text('Troubleshooting - Fix some app issues');
              },
              canTapOnHeader: true,
              isExpanded: _troubleshootExpanded,
              body: Column(
                children: [
                  Text('Update Data'),
                  Text('Force app to re-download all data'),
                  OutlineButton(
                    child: Text('Update now'),
                    onPressed: () {},
                  ),
                  Divider(height: 4),
                  Text('Reset App'),
                  Text('Resets all user settings and re-downloads all data'),
                  Icon(Icons.warning, color: Colors.red),
                  Text('This will reset the app to the initial state'),
                  OutlineButton(
                    child: Text('Reset App'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
