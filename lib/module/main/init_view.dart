// ignore_for_file: implementation_imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/getwidget.dart';

import '../../models/region.dart';
import '../../routes_config.dart';
import 'data_controller.dart';

class InitView extends StatefulWidget {
  const InitView({Key key, @required this.interruptedRoute}) : super(key: key);

  final RouteSettings interruptedRoute;

  @override
  _InitViewState createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  final DataController controller = GetIt.I.get<DataController>();

  bool _showConfig = false;
  int _regionNum;
  bool _finishDisabled = true;
  bool _dataLoaded = false;
  Future _dataLoading;

  void _setRegionNum(dynamic regionNum) {
    print('_setRegionNum( $regionNum )');
    controller.configureRegion(regionNum).then(
          (value) => setState(() {
            _regionNum = regionNum;
            _finishDisabled = (!_dataLoaded) || regionNum == null;
          }),
        );
  }

  void _resumeNavigation() {
    //Fallback to using default navigation method since we hijacked the
    //  Sailor routing mechanisms in util/ready_route_guard.dart
    Routing.sailor.navigatorKey.currentState.pushReplacementNamed(
      widget.interruptedRoute?.name ?? '/',
      arguments: widget.interruptedRoute?.arguments,
    );
  }

  @override
  void initState() {
    print('_initState');
    _showConfig = !controller.isAppConfigured;
    _dataLoading = controller.refreshData().whenComplete(() {
      _dataLoaded = true;
      if (_showConfig) {
        if (_regionNum != null) {
          setState(() {
            _finishDisabled = false;
          });
        }
      } else {
        _resumeNavigation();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('img/MainLogo.png'),
          const SizedBox(height: 10),
          FutureBuilder(
            future: _dataLoading,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return GFCard(
                  title: GFListTile(
                    titleText: 'Error',
                    icon: Icon(Icons.error_outline),
                    description: Text(snapshot.error),
                  ),
                );
              }

              if (snapshot.hasData) {
                return GFCard(
                  title: GFListTile(
                    titleText: 'Loading Game Data',
                    subtitleText: 'Success: Offline viewing enabled',
                  ),
                );
              }

              return GFCard(
                title: GFListTile(
                  titleText: 'Loading Game Data',
                  description: GFLoader(
                    type: GFLoaderType.circle,
                    loaderColorOne: Colors.blue,
                    loaderColorTwo: Colors.blue,
                    loaderColorThree: Colors.blue,
                  ),
                ),
              );
            },
          ),
          if (_showConfig) _buildConfig(context),
        ],
      ),
    );
  }

  Widget _buildConfig(BuildContext context) {
    return GFCard(
      title: GFListTile(
        titleText: 'Setup App',
        subtitleText: 'One-time setup to prepare the app for use',
      ),
      content: FormBuilderDropdown(
        attribute: 'region',
        onChanged: _setRegionNum,
        decoration: InputDecoration(
          hintText: 'Select your home region...',
          helperText:
              'Used to filter to a single region most places in the app',
        ),
        items: Region.REGIONS
            .map((r) => DropdownMenuItem<int>(
                  value: r.number,
                  child: Text('Region ${r.number} (${r.name})'),
                ))
            .toList(growable: false),
      ),
      buttonBar: GFButtonBar(
        children: [
          GFButton(
            onPressed: _finishDisabled ? null : _resumeNavigation,
            child: Text('Finish'),
            disabledColor: Colors.grey[300],
            disabledTextColor: Colors.grey[500],
          )
        ],
      ),
    );
  }
}
