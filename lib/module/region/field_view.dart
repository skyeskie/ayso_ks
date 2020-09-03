import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';

import '../../models/region.dart';
import '../../widgets/nav_bar.dart';

/// View for displaying the map of the fields for a specific region
class FieldView extends StatelessWidget {
  /// Construct view based on region number
  FieldView(this.regionNum) : mapName = Region.fromNumber(regionNum).fieldMap;

  /// Region number for the current display
  final int regionNum;

  /// Name of the (SVG) asset file for the field map
  final String mapName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey('FieldView'),
      appBar: buildNavBar('Region $regionNum Fields', context),
      body: PhotoView.customChild(
        child: SvgPicture.asset(
          mapName,
          height: 1000,
          width: 1000,
        ),
        childSize: Size(1000, 1000),
        backgroundDecoration: BoxDecoration(color: Colors.white),
      ),
    );
  }
}
