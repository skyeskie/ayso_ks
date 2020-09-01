import 'package:flutter/material.dart';

import '../../models/region.dart';
import '../../routes_config.dart';
import '../../widgets/large_icon_button.dart';

/// Display tile/card for a region
class RegionInfoTile extends StatelessWidget {
  /// Constant constructor
  const RegionInfoTile({
    Key key,
    this.region,
  }) : super(key: key);

  /// Information for the current region
  final Region region;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: ListTile(
                title: Text(
                  'Region ${region.number}',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  region.name,
                  textAlign: TextAlign.center,
                ),
              )),
          Expanded(
            flex: 2,
            //TODO(Responsive): Make buttons in-line
            child: Column(
              children: [
                SizedBox(height: 5),
                LargeIconButton(
                  action: () => Routing.sailor(
                    '/region/map',
                    params: {'regionNum': region.number},
                  ),
                  icon: Icons.drive_eta,
                  label: Text('Directions'),
                ),
                SizedBox(height: 3),
                LargeIconButton(
                  action: () => Routing.sailor(
                    '/region/field',
                    params: {'regionNum': region.number},
                  ),
                  icon: Icons.map,
                  label: Text('Field Map'),
                ),
                SizedBox(height: 5),
              ],
            ),
          )
        ],
      ),
    );
  }
}
