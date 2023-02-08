import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';

class ErrorTextDropdown extends StatelessWidget {
  final bool visible;
  final String? text;
  const ErrorTextDropdown({
    this.visible = false,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          text ??  '',
          textAlign: TextAlign.start,
          style: const TextStyle(color: ConstColors.danger, fontSize: 16),
        ),
    ));
  }
}