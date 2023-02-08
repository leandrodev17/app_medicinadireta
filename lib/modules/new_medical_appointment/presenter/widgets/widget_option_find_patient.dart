import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/const_colors.dart';
import '../../../../core/validators/app_validators.dart';
import '../controller/new_medical_appointment_controller.dart';
import '../list_patient_appointment_screen.dart';

class WidgetOptionFindPatient extends StatelessWidget {
  final NewMedicalAppointmentController controller;

  const WidgetOptionFindPatient({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) => ListPatientAppointmentScreen(), fullscreenDialog: true)),
      child: Obx(
        () {
          return TextFormField(
            key: ValueKey(controller.valueKeyFindPacient.value),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller.textFieldNamePatientFind,
            validator: AppValidators.required(m: 'Clique aqui para selecionar o paciente*'),
            enabled: false,
            decoration: InputDecoration(
              disabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: ConstColors.scheduleGridColor)),
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: ConstColors.scheduleGridColor)),
              errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: ConstColors.scheduleGridColor)),
              enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: ConstColors.scheduleGridColor)),
              focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: ConstColors.scheduleGridColor)),
              focusedErrorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: ConstColors.scheduleGridColor)),
              fillColor: ConstColors.scheduleGridColor,
              labelText: null,
              hintText: 'Selecionar um paciente*',
              hintStyle: GoogleFonts.openSans(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: ConstColors.scheduleGridColorText,
              ),
              prefixIcon: const Icon(Icons.person_search, size: 26, color: ConstColors.scheduleGridColorText),
              suffixIcon: const Icon(Icons.play_arrow, size: 26, color: ConstColors.scheduleGridColorText),
            ),
          );
        },
      ),
    );
  }
}
