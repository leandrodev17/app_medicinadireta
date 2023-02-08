import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';

class PageTile extends StatelessWidget {
  final String label;
  final String? iconDataImage;
  final IconData? iconData;
  final VoidCallback onTab;
  final bool highlight;
  final Color? colorHighlight;

  PageTile({
    required this.label,
     this.iconData,
    required this.onTab,
    required this.highlight,
    this.colorHighlight,
    this.iconDataImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(
          label,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        leading: iconDataImage != null ? Image.asset(iconDataImage!, width: 30) : Icon(iconData, size: 30, color: ConstColors.blue),
        trailing: colorHighlight == null
            ? Icon(Icons.arrow_forward_ios_outlined, size: 20, color: highlight ? ConstColors.blue : ConstColors.border)
            : Icon(Icons.arrow_forward_ios_outlined, size: 20, color: colorHighlight),
        onTap: onTab,
      ),
    );
  }
}
