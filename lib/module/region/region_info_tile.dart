import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:getwidget/components/button/gf_button.dart';

import '../../models/region.dart';

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
                onPressed: () =>
                    Modular.link.pushNamed('/${region.number}/map'),
                icon: Icon(Icons.drive_eta),
                text: 'Directions',
              ),
              GFButton(
                onPressed: () =>
                    Modular.link.pushNamed('/${region.number}/field'),
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
