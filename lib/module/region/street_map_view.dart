import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../widgets/nav_bar.dart';

class StreetMapView extends StatelessWidget {
  StreetMapView(this.regionNum);

  final int regionNum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Region $regionNum', context),
      body: PhotoView(
        imageProvider: AssetImage('img/osm_region49_1500sq.png'),
        initialScale: 1.0,
        minScale: 1.0,
        maxScale: 1.0,
        basePosition: Alignment(0.0, -0.9),
      ),
      floatingActionButton: RaisedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.navigation),
        label: Text('DUMMY MAP - ONLY STRIKER'),
      ),
    );
  }
}
