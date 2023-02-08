import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../number_record_patient.dart';

class DetailsCardPatient extends StatelessWidget {
  final ParamsToNavigationPage params;
  final bool openCard;

  DetailsCardPatient({required this.params, this.openCard = true});

  @override
  Widget build(BuildContext context) {
    String _labelAge = "age".tr;
    String _labelEmail = "email".tr;
    String _labelPhone = "phone".tr;
    String _name = params.nomeDoPaciente != null ? params.nomeDoPaciente.toString() : '--';
    String _age = params.idade != null ? "$_labelAge: ${params.idade.toString()}" : '--';
    String _mail = params.email != null ? "$_labelEmail: ${params.email.toString()}" : '--';
    String _phone = params.telefone != null ? "$_labelPhone: ${params.telefone.toString()}" : '--';
    String _numberProntuario = params.numeroDoProtuario != null ? params.numeroDoProtuario.toString() : '--';

    return AnimatedOpacity(
      opacity: openCard ? 1.0 : 0.0,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 900),
      child: Visibility(
        visible: openCard,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2.0, color: ConstColors.border),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NumberRecordPatient(title: 'patient_record'.tr, info: _numberProntuario.toString()),
              Text(_name.toUpperCase(), style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold)),
              Text(_age, style: Theme.of(context).textTheme.subtitle2),
              Text(_mail, style: Theme.of(context).textTheme.subtitle2),
              Text(_phone, style: Theme.of(context).textTheme.subtitle2),
            ],
          ),
        ),
      ),
    );
  }
}
