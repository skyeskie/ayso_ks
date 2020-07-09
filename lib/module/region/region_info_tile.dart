import 'package:ayso_ks/models/region.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

class RegionInfoTile extends StatelessWidget {
  final Region defaultRegion = const Region(
    id: 1,
    number: 40,
    name: 'Stryker',
    mapFile: 'map',
    lat: 10,
    lon: 20,
  );

  final Region region;

  const RegionInfoTile({
    Key key,
    this.region,
  }) : super(key: key);

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
