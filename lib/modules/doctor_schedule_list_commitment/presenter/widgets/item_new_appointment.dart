import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';

class ItemNewAppointment extends StatelessWidget {
  final String label;
  final VoidCallback onTab;
  ItemNewAppointment({Key? key, required this.label,  required this.onTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(label, style: Theme.of(context).textTheme.subtitle1),
      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15, color: ConstColors.orange),
      onTap: onTab,
    );
  }
}