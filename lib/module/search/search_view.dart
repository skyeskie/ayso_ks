import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../../dao/week_cache.dart';
import '../../models/age_group.dart';
import '../../models/gender.dart';
import '../../models/region.dart';
import '../../routes_config.dart';
import '../../widgets/nav_bar.dart';

/// Advanced search form
class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with WeekCacheInjection {
  final GlobalKey<FormBuilderState> _fb =
      GlobalKey<FormBuilderState>(debugLabel: 'SearchForm');
  final Widget spacer = const SizedBox(height: 40);

  int get _maxWeeks => weekCache.getMaxWeeks();

  void submitForm() {
    if (_fb.currentState.saveAndValidate()) {
      Routing.sailor(
        '/schedules/filtered',
        params: _fb.currentState.value,
      );
      print(_fb.currentState.value);
    }
  }

//TODO: Add cancel selection buttons
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
                Spacer(flex: 5),
                FormBuilderSlider(
                  numberFormat: NumberFormat('###'),
                  name: 'week',
                  min: 1,
                  max: _maxWeeks.toDouble(),
                  divisions: _maxWeeks - 1,
                  decoration: InputDecoration(
                    labelText: 'Week',
                    labelStyle: Theme.of(context).textTheme.headline6,
                    border: InputBorder.none,
                  ),
                  initialValue: 1,
                  valueTransformer: (v) => v.floor(),
                ),
                Spacer(),
                FormBuilderDropdown(
                  name: 'regionNum',
                  decoration: InputDecoration(labelText: 'Region'),
                  items: Region.REGIONS
                      .map((r) => DropdownMenuItem<int>(
                            value: r.number,
                            child: Text('${r.number} - ${r.name}'),
                          ))
                      .toList(growable: false),
                ),
                Spacer(flex: 2),
                Text(
                  'Division',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: FormBuilderDropdown(
                        name: 'age',
                        decoration: InputDecoration(labelText: 'Age'),
                        items: AgeGroup.AGES
                            .map((ag) => DropdownMenuItem<String>(
                                  value: ag.toString(),
                                  child: Text(ag.toString()),
                                ))
                            .toList(growable: false),
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: FormBuilderDropdown(
                        name: 'gender',
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
                Spacer(),
                Align(
                  child: RaisedButton.icon(
                    onPressed: submitForm,
                    icon: Icon(Icons.search),
                    label: Text('Go'),
                  ),
                ),
                Spacer(flex: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
