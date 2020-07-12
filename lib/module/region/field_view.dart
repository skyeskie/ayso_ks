import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      body: SvgPicture.asset(mapName),
    );
  }
}
