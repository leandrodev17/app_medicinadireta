import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';

import 'error_text_dropdown.dart';

class AppDropdown extends StatelessWidget {
  final dropdownValue;
  final String hintText;
  final String? hintError;
  final List<String> items;
  final Function(String?) onChange;
  final Color? focusColor;
  final bool visibleError;
  final TextStyle? textStyleDropdownValue;
  final TextStyle? textStyleHint;
  final double? width;
  final Color colorIconDropdown;

  AppDropdown({
    required this.dropdownValue,
    required this.hintText,
    required this.items,
    required this.onChange,
    this.focusColor,
    this.hintError,
    this.visibleError = false,
    this.textStyleDropdownValue,
    this.textStyleHint,
    this.width,
    this.colorIconDropdown = ConstColors.grey
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: width ?? MediaQuery.of(context).size.width - 60,
          child: Column(
            children: [
              DropdownButton(
                focusColor: focusColor,
                hint: dropdownValue == null
                    ? Text(hintText, style: textStyleHint ?? Theme.of(context).textTheme.subtitle2?.copyWith(height: .1))
                    : Text(dropdownValue, style: textStyleDropdownValue ?? Theme.of(context).textTheme.subtitle2),
                isExpanded: true,
                icon: Icon(Icons.expand_more_outlined, color: colorIconDropdown),
                iconSize: 30.0,
                items: items.map((val) {
                  return DropdownMenuItem<String>(value: val, child: Text(val));
                }).toList(),
                onChanged: onChange,
                underline: Container(color: ConstColors.grey, height: 1),
              ),
              ErrorTextDropdown(text: hintError, visible: visibleError),
            ],
          )),
    );
  }
}
