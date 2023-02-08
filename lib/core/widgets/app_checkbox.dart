import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  final bool checkboxValue;
  final String text;
  final Function(bool?) onChange;
  final MainAxisAlignment? mainAxisAlignment;
  final bool isSquare;
  final double? width;

  AppCheckbox({
    required this.checkboxValue,
    required this.text,
    required this.onChange,
    this.mainAxisAlignment,
    this.isSquare = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width ?? MediaQuery.of(context).size.width - 50,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: mainAxisAlignment == null ?
              MainAxisAlignment.start : MainAxisAlignment.start,
              children: [
                Checkbox(
                  activeColor: ConstColors.blue,
                  shape: isSquare? null : CircleBorder(),
                  value: checkboxValue,
                  onChanged: onChange,
                ),
                Text(text)
              ],
            ),
          ],
        ),
      ),
    );
  }
}