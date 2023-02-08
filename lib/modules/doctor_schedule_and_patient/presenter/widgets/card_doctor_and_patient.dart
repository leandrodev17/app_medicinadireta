import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/infra/models/doctor_schedule_and_patient_ext.dart';
import 'package:flutter/material.dart';

class CardDoctorAndPatient extends StatelessWidget {
  final DoctorScheduleAndPatientExt item;
  const CardDoctorAndPatient({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(item.hourFormatStart, style: Theme.of(context).textTheme.subtitle1!.copyWith(color: ConstColors.orange)),
                SizedBox(height: 10),
                Text(item.agendaConfig?.descricao?.trim().toUpperCase() ?? '', style: Theme.of(context).textTheme.subtitle1)
              ],
            ),
          ),
          Container(
            color: ConstColors.ligtherGrey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.paciente?.nome?.trim().toUpperCase() ?? ''),
                  SizedBox(height: 10),
                  Text(item.agendaStatus?.descricao?.trim().toUpperCase()?? ''),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
