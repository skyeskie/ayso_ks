import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';

import '../../models/region.dart';
import 'data_controller.dart';

class InitView extends StatefulWidget {
  const InitView({Key key, @required this.interruptedRoute}) : super(key: key);

  final RouteSettings interruptedRoute;

  @override
  _InitViewState createState() => _InitViewState();
}

class _InitViewState extends ModularState<InitView, DataController> {
  bool _showConfig = false;
  int _regionNum;
  bool _finishDisabled = true;
  bool _dataLoaded = false;
  Future _dataLoading;

  void _setRegionNum(int regionNum) {
    controller.configureRegion(regionNum).then(
          (value) => setState(() {
            _regionNum = regionNum;
            _finishDisabled = (!_dataLoaded) || regionNum == null;
          }),
        );
  }

  void _resumeNavigation() {
    Modular.to.pushNamed(
      widget.interruptedRoute?.name ?? '/',
      arguments: widget.interruptedRoute?.arguments,
    );
  }

  @override
  void initState() {
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
      content: DropdownButton(
        value: _regionNum,
        onChanged: _setRegionNum,
        items: [
          DropdownMenuItem(
            value: null,
            child: Text('Select your region...'),
          ),
          ...Region.REGIONS.map(
            (r) => DropdownMenuItem(
              value: r.number,
              child: Text('Region ${r.number} (${r.name})'),
            ),
          ),
        ],
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
