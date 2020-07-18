import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../../models/age_group.dart';
import '../../models/gender.dart';
import '../../models/region.dart';
import '../../routes_config.dart';
import '../../widgets/nav_bar.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final GlobalKey<FormBuilderState> _fb = GlobalKey<FormBuilderState>();
  final Widget spacer = const SizedBox(height: 40);

  void submitForm() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Search Games', context),
      body: FormBuilder(
        key: _fb,
        child: SizedBox.expand(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spacer,
                FormBuilderSlider(
                  numberFormat: NumberFormat('###'),
                  attribute: 'week',
                  min: 1,
                  max: 4,
                  divisions: 3,
                  decoration: InputDecoration(labelText: 'Week'),
                  initialValue: 1,
                  valueTransformer: (v) => v.floor(),
                ),
                SizedBox(height: 20),
                FormBuilderDropdown(
                  attribute: 'region',
                  decoration: InputDecoration(labelText: 'Region'),
                  items: Region.REGIONS
                      .map((r) => DropdownMenuItem<int>(
                            value: r.number,
                            child: Text('${r.number} - ${r.name}'),
                          ))
                      .toList(growable: false),
                ),
                spacer,
                Text(
                  'Division',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: FormBuilderDropdown(
                        attribute: 'age',
                        decoration: InputDecoration(labelText: 'Age'),
                        items: AgeGroup.AGES
                            .map((ag) => DropdownMenuItem<String>(
                                  value: ag.toString(),
                                  child: Text(ag.toString()),
                                ))
                            .toList(growable: false),
                      ),
                    ),
                    Expanded(
                      child: FormBuilderDropdown(
                        attribute: 'gender',
                        decoration: InputDecoration(labelText: 'Gender'),
                        items: Gender.GENDERS
                            .map((g) => DropdownMenuItem<String>(
                                  value: g.long,
                                  child: Text(g.long),
                                ))
                            .toList(growable: false),
                      ),
                    ),
                  ],
                ),
                spacer,
                Align(
                  child: RaisedButton.icon(
                    onPressed: () {
                      if (_fb.currentState.saveAndValidate()) {
                        Routing.sailor(
                          '/schedules/filtered',
                          params: _fb.currentState.value,
                        );
                        print(_fb.currentState.value);
                      }
                    },
                    icon: Icon(Icons.search),
                    label: Text('Go'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
