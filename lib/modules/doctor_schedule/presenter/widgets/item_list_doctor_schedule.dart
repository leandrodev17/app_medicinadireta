import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:flutter/material.dart';

class ItemListDoctorSchedule extends StatelessWidget {
  final String label;
  final VoidCallback onTab;
  final EdgeInsets? contentPadding;
  const ItemListDoctorSchedule({Key? key, required this.label, required this.onTab, this.contentPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 8,
      contentPadding: contentPadding ?? EdgeInsets.zero,
      dense: false,
      horizontalTitleGap: 30,
      title: Text(
        label,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 14.spEx, fontWeight: FontWeight.w500, color: ConstColors.graphite),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 25, color: ConstColors.cinza3),
      onTap: onTab,
    );
  }
}
