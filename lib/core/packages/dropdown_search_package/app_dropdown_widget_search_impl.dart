import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/helpers/helpers.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field_decoration.dart';

import 'app_dropdown_widget_search.dart';
import 'searchable_dropdown/lib/dropdown_search.dart';
import 'searchable_dropdown/lib/src/properties/properties.dart';

enum ModeEnum { DIALOG, BOTTOM_SHEET, MENU }

class AppDropdownWidgetSearchImpl<T> extends StatelessWidget {
  final List<T>? items;
  final T? selectedItem;
  final String? Function(T?)? validator;
  final Function(T?)? onChanged;
  final bool enabled;
  final bool showSearchBox;
  final Function(T?)? onSaved;
  final String? labelText;
  final ModeEnum mode;
  final EdgeInsetsGeometry? contentPaddingLabelText;
  final bool? alignLabelWithHint;
  final InputBorder border;
  final EdgeInsets? padding;
  final String? hintText;
  final TextStyle? hintStyle;
  final bool fieldRequired;
  final String? errorText;
  final bool loadingData;
  final TextStyle? dropdownSearchBaseStyle;
  final String Function(T?)? itemAsString;
  final Color? fillColor;
  final TextEditingController? searchControllerEC;
  final bool autofocus;
  final Function()? onPressedSuffixIcon;

  ///	custom filter function
  final DropdownSearchFilterFn<T>? filterFn;
  final DropdownSearchOnFind<T>? onFind;
  final bool isDecorationNotBorder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color borderSideColor;

  const AppDropdownWidgetSearchImpl({
    Key? key,
    this.items,
    this.selectedItem,
    this.validator,
    this.enabled = true,
    this.showSearchBox = true,
    this.onSaved,
    this.labelText,
    this.onChanged,
    this.contentPaddingLabelText,
    this.alignLabelWithHint,
    this.mode = ModeEnum.BOTTOM_SHEET,
    this.border = const UnderlineInputBorder(),
    this.padding,
    this.hintText,
    this.hintStyle,
    this.fieldRequired = false,
    this.errorText,
    this.loadingData = false,
    this.dropdownSearchBaseStyle,
    this.itemAsString,
    this.fillColor,
    this.searchControllerEC,
    this.autofocus = true,
    this.onPressedSuffixIcon,
    this.filterFn,
    this.onFind,
    this.prefixIcon,
    this.suffixIcon,
    this.isDecorationNotBorder = false,
    this.borderSideColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputDecoration? decorationPre = isDecorationNotBorder
        ? decorationNotBorder(
            enabled: enabled,
            prefixIcon: prefixIcon,
            errorText: errorText != '' ? errorText : null,
            hintText: hintText,
            labelText: labelText,
            fieldRequired: fieldRequired,
            suffixIcon: suffixIcon,
            borderSideColor: borderSideColor,
            hintStyle: hintStyle,
            fillColor: fillColor,
          )
        : appTextFieldDecoration(
            enabled: enabled,
            prefixIcon: loadingData ? const CupertinoActivityIndicator() : null,
            errorText: errorText != '' ? errorText : null,
            hintText: hintText,
            labelText: labelText,
            fieldRequired: fieldRequired,
          );
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDropdownWidgetSearch(
          mode: mode == ModeEnum.BOTTOM_SHEET ? Mode.BOTTOM_SHEET : (mode == ModeEnum.DIALOG ? Mode.DIALOG : Mode.MENU),
          items: items,
          onChanged: onChanged,
          selectedItem: selectedItem,
          validator: validator,
          enabled: enabled,
          onSaved: onSaved,
          showSearchBox: showSearchBox,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          dropdownSearchBaseStyle: const TextStyle(color: Colors.red),
          showAsSuffixIcons: true,
          searchFieldProps: TextFieldProps(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            controller: searchControllerEC,
            autofocus: autofocus,
            decoration: InputDecoration(
              hintText: 'O que deseja pesquisar?',
              border: const UnderlineInputBorder(),
              suffixIcon: Visibility(visible: onPressedSuffixIcon != null, child: IconButton(onPressed: onPressedSuffixIcon, icon: const Icon(Icons.search))),
            ),
          ),
          dropdownSearchDecoration: decorationPre,
          itemAsString: itemAsString,
          fillColor: fillColor,
          filterFn: filterFn,
          onFind: onFind,
        ),
      ],
    );
  }
}
