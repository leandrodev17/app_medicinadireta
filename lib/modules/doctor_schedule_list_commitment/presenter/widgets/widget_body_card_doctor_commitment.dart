import 'package:flutter/material.dart';

class WidgetBodyCardDoctorCommitment extends StatelessWidget {
  final Color background;
  final String text;
  final EdgeInsets? padding;
  WidgetBodyCardDoctorCommitment({Key? key, required this.background, required this.text, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      padding: padding ?? EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(text),
    );
  }
}
