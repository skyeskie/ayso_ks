import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

import '../../models/region.dart';
import '../../routes_config.dart';

class RegionInfoTile extends StatelessWidget {
  const RegionInfoTile({
    Key key,
    this.region,
  }) : super(key: key);

  final Region region;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      color: Colors.blueGrey,
      child: Column(
        children: [
          Row(
            children: [
              Text('Region ${region.number}'),
              Text(region.name),
            ],
          ),
          Row(
            children: [
              GFButton(
                onPressed: () => Routing.sailor(
                  'region/map',
                  params: {'regionNum': region.number},
                ),
                icon: Icon(Icons.drive_eta),
                text: 'Directions',
              ),
              GFButton(
                onPressed: () => Routing.sailor(
                  'region/field',
                  params: {'regionNum': region.number},
                ),
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
