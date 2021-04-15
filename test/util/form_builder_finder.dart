import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

extension FindWithFormBuilder on CommonFinders {
  Finder formBuilderAttribute(String attribute, {bool skipOffstage = true}) {
    return FormBuilderFinder(attribute, skipOffstage: skipOffstage);
  }
}

class FormBuilderFinder extends MatchFinder {
  FormBuilderFinder(this.attribute, {bool skipOffstage = true})
      : super(skipOffstage: skipOffstage);

  final String attribute;

  @override
  String get description => 'Matches a FormBuilder element by attribute prop';

  @override
  bool matches(Element candidate) {
    final widget = candidate.widget;
    if (widget is FormBuilderCheckbox) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderCheckboxGroup) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderChipsInput) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderChoiceChip) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderDateRangePicker) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderDateTimePicker) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderDropdown) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderFilterChip) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderRadioGroup) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderRadioGroup) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderRangeSlider) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderRating) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderSegmentedControl) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderSignaturePad) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderSlider) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderSwitch) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderTextField) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderTouchSpin) {
      return widget.name == attribute;
    }
    if (widget is FormBuilderTypeAhead) {
      return widget.name == attribute;
    }
    return false;
  }
}
