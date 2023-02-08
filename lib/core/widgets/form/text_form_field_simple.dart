import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';

class TextFormFieldSimple extends StatelessWidget {
  final Key? key;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextStyle? style;
  final bool? enabled;
  final InputDecoration? decoration;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final TextStyle? hintStyleDecoration;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final bool autofocus;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool fieldRequired;
  const TextFormFieldSimple({
    this.key,
    this.validator,
    this.controller,
    this.style,
    this.enabled,
    this.decoration,
    this.labelText,
    this.hintText,
    this.hintStyleDecoration,
    this.onSaved,
    this.onTap,
    this.onChanged,
    this.autofocus = false,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.initialValue,
    this.fieldRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: initialValue,
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      autofocus: autofocus,
      maxLines: 10,
      minLines: 1,
      style: style ??
          GoogleFonts.openSans(
            fontSize: 14.spEx,
            fontWeight: FontWeight.w500,
            color: ConstColors.cinza,
          ),
      decoration: decoration ??
          InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: InputBorder.none,
            labelText: !fieldRequired ? toBeginningOfSentenceCase(labelText ?? '') : null,
            label: fieldRequired ? wi(labelText!) : null,
            hintText: hintText,
            errorMaxLines: 2,
            hintStyle: hintStyleDecoration ??
                GoogleFonts.openSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 13.spEx,
                  decoration: TextDecoration.underline,
                  color: ConstColors.cinza,
                ),
            suffixIcon: suffixIcon ?? Icon(Icons.search, size: 24.hEx, color: ConstColors.orange),
            prefixIcon: prefixIcon,
          ),
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
      onSaved: onSaved,
    );
  }

  wi(String label) => RichText(
        maxLines: 1,
        text: TextSpan(
          text: toBeginningOfSentenceCase(label),
          style: GoogleFonts.openSans(fontSize: 16.0, color: ConstColors.blue, fontWeight: FontWeight.w700),
          children: [
            TextSpan(
              text: ' *',
              style: GoogleFonts.openSans(fontSize: 16.0, color: ConstColors.danger, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );
}
