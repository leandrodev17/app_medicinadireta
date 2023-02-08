import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/cupertino.dart';

class SwitchControlWidget extends StatelessWidget {
  final int selectedValue;
  final Function(int) onValueChanged;
  final Map<int, Widget> controls;

  const SwitchControlWidget({
    required this.selectedValue,
    required this.controls,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl(
      children: controls,
      borderColor: ConstColors.blue,
      selectedColor: ConstColors.blue,
      groupValue: selectedValue,
      onValueChanged: onValueChanged,
    );
  }
}
