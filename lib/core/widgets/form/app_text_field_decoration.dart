import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

import 'package:medicinadireta/constants/const_colors.dart';

InputDecoration appTextFieldDecoration({
  bool? enabled,
  bool isHintStyle = false,
  bool fieldRequired = false,
  Widget? suffixIcon,
  Widget? prefixIcon,
  String? errorText,
  String? hintText,
  String? labelText,
  TextStyle? labelStyle,
}) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    counterText: '',
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,
    errorText: errorText,
    hintText: hintText,
    labelText: !fieldRequired ? toBeginningOfSentenceCase(labelText ?? '') : null,
    label: fieldRequired ? wi(labelText ?? '') : null,
    labelStyle: labelStyle,
  );
}

InputDecoration decorationNotBorder({
  bool? enabled,
  bool isHintStyle = false,
  bool fieldRequired = false,
  Widget? suffixIcon,
  Widget? prefixIcon,
  String? errorText,
  String? hintText,
  String? labelText,
  TextStyle? labelStyle,
  Color borderSideColor = Colors.white,
  TextStyle? hintStyle,
  Color? fillColor = Colors.white,
}) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    fillColor: fillColor,
    counterText: '',
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,
    errorText: errorText,
    hintText: hintText,
    hintStyle: hintStyle,
    labelText: labelText,
    disabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: borderSideColor)),
    focusedBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: borderSideColor)),
    errorBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: borderSideColor)),
    enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: borderSideColor)),
    focusedErrorBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: borderSideColor)),
    border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: borderSideColor)),
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
