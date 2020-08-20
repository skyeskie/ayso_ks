import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:photo_view/photo_view.dart';

import '../../models/region.dart';
import '../../widgets/nav_bar.dart';

/// View for showing road maps to specific regions
class StreetMapView extends StatelessWidget {
  /// Constructor based on the region number
  StreetMapView(this.regionNum) : _region = Region.fromNumber(regionNum);

  /// Region number for the current view
  final int regionNum;

  final Region _region;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Region $regionNum', context),
      body: PhotoView(
        imageProvider: AssetImage(_region.streetMap),
        initialScale: 1.0,
        minScale: 1.0,
        maxScale: 1.0,
        basePosition: Alignment(0.0, -0.9),
      ),
      floatingActionButton: RaisedButton.icon(
        onPressed: () => MapsLauncher.launchCoordinates(
          _region.lat,
          _region.lon,
        ),
        icon: Icon(Icons.navigation),
        label: Text('Open in Map App'),
      ),
    );
  }
}
