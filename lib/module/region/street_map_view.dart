import 'package:flutter/material.dart';

class StreetMapView extends StatelessWidget {
  StreetMapView(this.regionNum);

  final int regionNum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Region $regionNum')),
    );
  }
}
