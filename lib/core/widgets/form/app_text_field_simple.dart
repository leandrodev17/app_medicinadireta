import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';

import 'app_text_field_decoration.dart';

class AppTextFieldSimple extends StatelessWidget {
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
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const AppTextFieldSimple({
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
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

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
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          counterText: '',
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          errorText: errorText,
          hintText: hintText,
          labelText: labelText,
          disabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: Colors.white)),
          errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: Colors.white)),
          enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: Colors.white)),
          focusedErrorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: Colors.white)),
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: Colors.white)),
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
        style: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ConstColors.cinza,
        ),
      ),
    );
  }
}
