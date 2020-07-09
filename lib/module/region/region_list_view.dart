import 'package:flutter/material.dart';

import '../../models/region.dart';
import 'region_info_tile.dart';

class RegionListView extends StatelessWidget {
  final List<Region> regions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: regions.length,
        itemBuilder: (ctx, n) => RegionInfoTile(
          region: regions[n],
        ),
      ),
    );
  }
}
