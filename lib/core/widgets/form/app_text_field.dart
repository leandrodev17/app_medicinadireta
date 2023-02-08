import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';

import 'app_text_field_decoration.dart';

class AppTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final bool enabled;
  final FormFieldValidator<String?>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldSetter<String>? onChanged;
  final FormFieldSetter<String?>? onSaved;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final String? errorText;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final ValueChanged<String>? onFieldSubmitted;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final bool visibleSuffixIcon;
  final bool visiblePrefixIcon;
  final int minLines;
  final int maxLines;
  final Function()? onPressedSuffixIcon;
  final Function()? onPressedPrefixIcon;
  final Widget? suffixIconWidget;
  final bool fieldRequired;
  final EdgeInsets? padding;
  final Function()? onTap;

  const AppTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.enabled = true,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.keyboardType,
    this.hintStyle,
    this.errorText,
    this.maxLength,
    this.focusNode,
    this.textInputAction,
    this.controller,
    this.onFieldSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.visibleSuffixIcon = false,
    this.visiblePrefixIcon = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.onPressedSuffixIcon,
    this.onPressedPrefixIcon,
    this.onSaved,
    this.suffixIconWidget,
    this.fieldRequired = false,
    this.padding,
    this.onTap,
  }) : super(key: key);

  Widget _suffixIcon() {
    return IconButton(
      color: Colors.red,
      alignment: Alignment.centerRight,
      icon: suffixIconWidget ?? Container(),
      onPressed: onPressedSuffixIcon,
    );
  }

  Widget _prefixIcon() {
    return IconButton(
      color: Colors.red,
      alignment: Alignment.centerRight,
      icon: const Icon(Icons.visibility, color: ConstColors.fillColor),
      onPressed: onPressedPrefixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: TextFormField(
        textCapitalization: textCapitalization,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        enabled: enabled,
        autofocus: autofocus,
        cursorColor: ConstColors.cursorColor,
        obscureText: obscureText,
        decoration: appTextFieldDecoration(
          enabled: enabled,
          suffixIcon: visibleSuffixIcon ? _suffixIcon() : null,
          prefixIcon: visiblePrefixIcon ? _prefixIcon() : null,
          errorText: errorText != '' ? errorText : null,
          hintText: hintText,
          labelText: labelText,
          fieldRequired: fieldRequired,
          // labelStyle: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 14.spEx, fontWeight: FontWeight.w900),
        ),
        onChanged: onChanged,
        onTap: onTap,
        onSaved: onSaved,
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onFieldSubmitted: onFieldSubmitted,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 14.spEx, fontWeight: FontWeight.w400, 
        color: ConstColors.cinza,),
      ),
    );
  }
}
