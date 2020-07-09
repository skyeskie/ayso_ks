import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

import '../../models/region.dart';

class RegionInfoTile extends StatelessWidget {
  const RegionInfoTile({
    Key key,
    this.region,
  }) : super(key: key);

  final Region defaultRegion = const Region(
    id: 1,
    number: 40,
    name: 'Stryker',
    mapFile: 'map',
    lat: 10,
    lon: 20,
  );

  final Region region;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: Column(
        children: [
          Row(
            children: [
              Text('Region ${defaultRegion.number}'),
              Text(defaultRegion.name),
            ],
          ),
          Row(
            children: [
              GFButton(
                onPressed: () => {},
                icon: Icon(Icons.drive_eta),
                text: 'Directions',
              ),
              GFButton(
                onPressed: () => {},
                icon: Icon(Icons.map),
                text: 'Field Map',
              )
            ],
          )
        ],
      ),
    );
  }
}
