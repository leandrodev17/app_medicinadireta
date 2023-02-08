import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RadioButtonGroup extends StatelessWidget {
  final int? groupValue;
  final String? title;
  final List<String>? labels;
  final Function(int?)? onChanged;
  final bool visibleStyle;

  const RadioButtonGroup({
    super.key,
    this.groupValue,
    this.title,
    this.labels,
    this.onChanged,
    this.visibleStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    if (title != null) {
      children.add(Text(title!, textAlign: TextAlign.start));
    }

    labels!.asMap().forEach(
      (index, label) {
        children.add(
          Row(
            children: <Widget>[
              Radio(
                value: index,
                groupValue: groupValue,
                fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return ConstColors.blue.withOpacity(.32);
                  }
                  return ConstColors.blue;
                }),
                onChanged: onChanged,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onChanged!(index);
                  },
                  child: Text(
                    label,
                    style: visibleStyle
                        ? GoogleFonts.openSans(
                            color: ConstColors.blue,
                            fontWeight: index == 1 && groupValue == 1
                                ? FontWeight.w700
                                : (index == 0 && groupValue == 0
                                    ? FontWeight.w700
                                    : index == 2 && groupValue == 2
                                        ? FontWeight.w700
                                        : FontWeight.w400),
                            fontSize: 14.spEx,
                          )
                        : null,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
