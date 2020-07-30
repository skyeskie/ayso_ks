import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../models/region.dart';
import '../../routes_config.dart';

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
    return GFCard(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      title: GFListTile(
        titleText: 'Region ${region.number}',
        subtitleText: region.name,
      ),
      content: GFButtonBar(
        spacing: 40,
        children: [
          GFButton(
            onPressed: () => Routing.sailor(
              '/region/map',
              params: {'regionNum': region.number},
            ),
            icon: Icon(Icons.drive_eta),
            text: 'Directions',
          ),
          GFButton(
            onPressed: () => Routing.sailor(
              '/region/field',
              params: {'regionNum': region.number},
            ),
            icon: Icon(Icons.map),
            text: 'Field Map',
          ),
        ],
      ),
    );
  }
}
