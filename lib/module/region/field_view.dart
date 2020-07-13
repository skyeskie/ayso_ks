import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';

import '../../models/region.dart';
import '../../widgets/nav_bar.dart';

class FieldView extends StatelessWidget {
  FieldView(this.regionNum) : mapName = Region.fromNumber(regionNum).mapFile;

  final int regionNum;
  final String mapName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
