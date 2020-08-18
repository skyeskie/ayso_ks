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
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderCheckboxGroup) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderChipsInput) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderChoiceChip) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderCountryPicker) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderDateRangePicker) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderDateTimePicker) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderDropdown) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderFilterChip) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderImagePicker) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderPhoneField) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderRadioGroup) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderRadioGroup) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderRangeSlider) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderRate) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderSegmentedControl) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderSignaturePad) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderSlider) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderSwitch) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderTextField) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderTouchSpin) {
      return widget.attribute == attribute;
    }
    if (widget is FormBuilderTypeAhead) {
      return widget.attribute == attribute;
    }
    return false;
  }
}
