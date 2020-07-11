import 'package:flutter/material.dart';
import 'package:liquid_ui/liquid_ui.dart';

import '../../models/age_group.dart';
import '../../models/gender.dart';
import '../../models/region.dart';
import '../../widgets/nav_bar.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  LFormManager _formManager;
  final GlobalKey<LDropdownState> _week = GlobalKey<LDropdownState>();
  double _weekNum = 1;

  void submitForm() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Search Games', context),
      body: LForm(
        manager: _formManager,
        child: SizedBox.expand(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Week ${_weekNum?.floor()}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Slider(
                  value: _weekNum,
                  min: 1,
                  max: 4,
                  divisions: 3,
                  onChanged: (value) {
                    setState(() {
                      _weekNum = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Region',
                  style: Theme.of(context).textTheme.headline6,
                ),
                DropdownButtonFormField(
                  onChanged: (value) {},
                  items: Region.REGIONS
                      .map((r) => DropdownMenuItem<Region>(
                            value: r,
                            child: Text(r.name),
                          ))
                      .toList(growable: false),
                ),
                Text(
                  'Division',
                  style: Theme.of(context).textTheme.headline6,
                ),
                FractionallySizedBox(
                  widthFactor: .3,
                  child: DropdownButtonFormField(
                    onChanged: (value) {},
                    isDense: true,
                    items: AgeGroup.AGES
                        .map((ag) => DropdownMenuItem<AgeGroup>(
                              value: ag,
                              child: Text(ag.toString()),
                            ))
                        .toList(growable: false),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: .3,
                  child: DropdownButtonFormField(
                    onChanged: (value) {},
                    isDense: true,
                    items: Gender.GENDERS
                        .map((g) => DropdownMenuItem<Gender>(
                              value: g,
                              child: Text(g.long),
                            ))
                        .toList(growable: false),
                  ),
                ),
                RaisedButton.icon(
                  onPressed: submitForm,
                  icon: Icon(Icons.search),
                  label: Text('Go'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
