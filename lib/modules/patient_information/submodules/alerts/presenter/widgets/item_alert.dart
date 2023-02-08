import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/modules/patient_information/presenter/controller/patient_datails_controller.dart';
import 'package:flutter/material.dart';

class ItemAlert extends StatelessWidget {

  final SubItemAlert? data;

  const ItemAlert({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data?.titulo?.toString() ?? '--',
          style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 3),
        Text(data?.tipo?.toString() ?? '--', style: Theme.of(context).textTheme.subtitle1?.copyWith(color: ConstColors.blue, fontWeight: FontWeight.w900)),
        const SizedBox(height: 3),
        Text(data?.medicamento?.toString() ?? '--', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: ConstColors.blue, fontWeight: FontWeight.w300)),
      ],
    );
  }
}
