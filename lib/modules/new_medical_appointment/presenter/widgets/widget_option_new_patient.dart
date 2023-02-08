import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/const_colors.dart';
import '../../../../core/validators/app_validators.dart';
import '../controller/new_medical_appointment_controller.dart';
import '../new_patient_appointment_screen.dart';

class WidgetOptionNewPatient extends StatelessWidget {
  final NewMedicalAppointmentController controller;
  const WidgetOptionNewPatient({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) => const NewPatientAppointmentScreen(), fullscreenDialog: true)),
      child: Obx(() {
        return TextFormField(
          key: ValueKey(controller.valueKeyNewPacient.value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.textFieldNewPatient,
          validator: AppValidators.required(m: 'Clique aqui para cadastrar um paciente*'),
          enabled: false,
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: ConstColors.orange,
          ),
          decoration: InputDecoration(
            disabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: ConstColors.ffFEE3DE)),
            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: ConstColors.ffFEE3DE)),
            errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: ConstColors.ffFEE3DE)),
            enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: ConstColors.ffFEE3DE)),
            focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: ConstColors.ffFEE3DE)),
            focusedErrorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: ConstColors.ffFEE3DE)),
            fillColor: ConstColors.ffFEE3DE,
            labelText: null,
            hintText: 'Cadastrar um paciente *',
            hintStyle: GoogleFonts.openSans(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: ConstColors.orange,
            ),
            prefixIcon: const Icon(Icons.person_add, size: 26, color: ConstColors.orange),
            suffixIcon: const Icon(Icons.add, size: 26, color: ConstColors.orange),
          ),
        );
      }),
    );
  }
}
