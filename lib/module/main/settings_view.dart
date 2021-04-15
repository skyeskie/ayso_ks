import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../dao/settings.dart';
import '../../models/region.dart';
import '../../widgets/nav_bar.dart';

/// View for configuring app-wide settings
class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with SettingsInjection {
  SettingsDataType _settings;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

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
      key: ValueKey('SettingsView'),
      appBar: buildNavBar('Settings', context),
      body: _settings == null
          ? _buildLoading(context)
          : FormBuilder(
              key: _fbKey,
              initialValue: {
                'confirm': false,
              },
              child: _build(context),
            ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Text('Loading...');
  }

  Widget _build(BuildContext context) {
    return Column(
      children: [
        FormBuilderRadioGroup(
          name: 'region',
          orientation: OptionsOrientation.vertical,
          initialValue: _settings.regionNumber,
          decoration: InputDecoration(
            labelText: 'Home Region',
            labelStyle: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.grey,
                ),
            contentPadding: EdgeInsets.all(15),
            border: InputBorder.none,
          ),
          onChanged: (regionNum) =>
              settingsDAO.setRegion(regionNum).then((_) => _updateSettings()),
          options: Region.REGIONS
              .map((r) => FormBuilderFieldOption(
                    value: r.number,
                    child: Text('Region ${r.number} (${r.name})'),
                    key: ValueKey('regionRadio_${r.number}'),
                  ))
              .toList(growable: false),
        ),
//TODO: Add in troubleshooting
// [ ] Add in DataController
// [ ] Link in with 'Update Data'
// [ ] Reflect loading - Loading Button?
//TODO: Maybe add-in reset
// [ ] Add in confirmation. Modal?
// [ ] Route to Init view then back OR handle like Update Data
//
//        SizedBox(height: 30),
//        Text(
//          'Troubleshooting',
//          style: Theme.of(context).textTheme.headline6.copyWith(
//                color: Colors.orange[800],
//              ),
//        ),
//        GFListTile(
//          titleText: 'Update Data',
//          subtitleText: 'Force app to re-download all data',
//          icon: Icon(Icons.update),
//          description: Align(
//            child: RaisedButton(
//              child: Text('Update now'),
//              onPressed: null,
//            ),
//          ),
//        ),
      ],
    );
  }
}
