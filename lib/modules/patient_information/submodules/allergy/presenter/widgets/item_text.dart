import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:flutter/material.dart';

class ItemText extends StatelessWidget {
  final String title;
  final String description;
  final Color? colorDescription;
  final Color? colorTitle;
  final TextStyle? textStyleDescription;

  const ItemText({
    Key? key,
    required this.title,
    required this.description,
    this.colorDescription,
    this.colorTitle,
    this.textStyleDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: TextStyle(color: colorTitle ?? ConstColors.cinza2, fontSize: 10.spEx, fontWeight: FontWeight.w400)),
        Text(
          description.toUpperCase(),
          style: textStyleDescription ??
              TextStyle(
                color: ConstColors.cinza,
                fontSize: 14.spEx,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
