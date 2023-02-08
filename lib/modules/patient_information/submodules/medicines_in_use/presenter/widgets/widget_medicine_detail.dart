import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';

class WidgetMedicineDetail extends StatelessWidget {
  final String title;
  final String detail;
  const WidgetMedicineDetail({
    Key? key,
    required this.title,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            color: ConstColors.lightFillColor,
            height: 30,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            child: Text(title, style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w400, color: Colors.white)),
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            child: Text(detail, style: Theme.of(context).textTheme.subtitle2),
          ),
        ],
      ),
    );
  }
}
