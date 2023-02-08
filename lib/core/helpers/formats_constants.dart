import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormatsConstants {
  FormatsConstants._();
  static final CPF = MaskTextInputFormatter(mask: "###.###.###-##");
  static final MaskTextInputFormatter  phoneMask = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  static MaskTextInputFormatter get phoneMaskFormatter => MaskTextInputFormatter(mask: '(##) #########', filter: {"#": RegExp(r'[0-9]')});
  static MaskTextInputFormatter get cpfMaskFormatter => MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
}

extension MaskUtils on MaskTextInputFormatter {
  String format({String? value}) {
    if (value == null) return '';
    return this.formatEditUpdate(const TextEditingValue(), TextEditingValue(text: value)).text;
  }

  String unmask({String? value}) {
    if (value == null) return '';
    this.formatEditUpdate(const TextEditingValue(), TextEditingValue(text: value));
    return this.getUnmaskedText();
  }

}
