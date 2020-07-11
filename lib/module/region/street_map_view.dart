import 'package:flutter/material.dart';

import '../../widgets/nav_bar.dart';

class StreetMapView extends StatelessWidget {
  StreetMapView(this.regionNum);

  final int regionNum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Region $regionNum', context),
    );
  }
}
