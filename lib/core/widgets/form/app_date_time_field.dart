import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';

import 'app_text_field_decoration.dart';

class AppDateTime extends StatelessWidget {
  final String? label;
  final String? errorText;
  final DateTime? initialValue;
  final String? Function(DateTime?)? validator;
  final Function(DateTime?)? onChanged;
  final bool allowBefore;
  final bool allowAfter;
  final bool timer;
  final bool enabled;
  final bool loadingData;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Icon? resetIcon;
  final Function(DateTime?)? onSaved;
  final Widget? suffix;
  final EdgeInsets? padding;
  final String? hintText;
  final TextStyle? hintStyle;
  final bool fieldRequired;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isDecorationNotBorder;

  // final bool enabled;

  const AppDateTime({
    Key? key,
    this.label,
    this.errorText,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.allowBefore = true,
    this.allowAfter = true,
    this.timer = true,
    this.enabled = true,
    this.loadingData = false,
    this.controller,
    this.focusNode,
    this.resetIcon = const Icon(Icons.close),
    this.onSaved,
    this.suffix,
    this.padding,
    this.hintText,
    this.hintStyle,
    this.fieldRequired = false,
    this.prefixIcon,
    this.suffixIcon,
    this.isDecorationNotBorder = false,
    // this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputDecoration? decorationPre = isDecorationNotBorder
        ? decorationNotBorder(
            enabled: enabled,
            prefixIcon: prefixIcon,
            errorText: errorText != '' ? errorText : null,
            hintText: hintText,
            labelText: label,
            fieldRequired: fieldRequired,
            suffixIcon: suffixIcon,
          )
        : appTextFieldDecoration(
            enabled: enabled,
            prefixIcon: loadingData ? const CupertinoActivityIndicator() : null,
            errorText: errorText != '' ? errorText : null,
            hintText: hintText,
            labelText: label,
            fieldRequired: fieldRequired,
          );

    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 20),
      child: DateTimeField(
        format: timer ? FormatsDatetime.dateHourFormat : FormatsDatetime.dateFormat,
        // style: Theme.of(context).textTheme.subtitle2,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 14.spEx, fontWeight: FontWeight.w400, color: ConstColors.cinza),
        resetIcon: resetIcon,
        controller: controller,
        focusNode: focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: decorationPre,
        initialValue: initialValue,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        enabled: enabled,
        enableInteractiveSelection: false,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
            context: context,
            locale: const Locale("pt", "BR"),
            firstDate: allowBefore ? DateTime(1900) : DateTime.now().subtract(const Duration(days: 1)),
            lastDate: allowAfter ? DateTime(DateTime.now().year + 1, 12, 30) : DateTime.now(),
            // firstDate: allowBefore ? DateTime.now().subtract(const Duration(days: 37000)) : DateTime.now().subtract(const Duration(days: 1)),
            // lastDate: allowAfter ? DateTime.now().add(const Duration(days: 37000)) : DateTime.now().add(const Duration(days: 1)),
            initialDate: currentValue ?? DateTime.now(),
          );
          if (date != null && timer) {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else if (date != null) {
            return date;
          } else {
            return currentValue;
          }
        },
      ),
    );
  }
}
