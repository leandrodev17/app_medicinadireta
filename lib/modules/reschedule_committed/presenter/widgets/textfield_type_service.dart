import 'package:flutter/material.dart';

class TextFieldObservation extends StatelessWidget {
  final int? maxLines;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enableBorder;
  final InputBorder? focusedBorder;

  const TextFieldObservation({
    Key? key,
    this.focusedBorder,
    this.contentPadding,
    this.enableBorder,
    this.hintText,
    this.maxLines,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: contentPadding,
          enabledBorder: enableBorder,
          focusedBorder: focusedBorder,
        ),
      ),
    );
  }
}
