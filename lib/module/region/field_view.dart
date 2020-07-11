import 'package:flutter/material.dart';

import '../../widgets/nav_bar.dart';

class FieldView extends StatelessWidget {
  const FieldView(this.regionNum);

  final int regionNum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Region $regionNum', context),
    );
  }
}
