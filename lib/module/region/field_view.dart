import 'package:flutter/material.dart';

class FieldView extends StatelessWidget {
  const FieldView(this.regionNum);

  final int regionNum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Region $regionNum')),
    );
  }
}
