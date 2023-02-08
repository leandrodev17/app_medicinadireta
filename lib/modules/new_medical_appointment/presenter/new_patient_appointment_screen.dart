import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/new_medical_appointment/presenter/pages/new_patient_appointment_phone.dart';
import 'package:flutter/material.dart';

class NewPatientAppointmentScreen extends StatelessWidget {
  const NewPatientAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => const NewPatientAppointmentPhone(),
        landscape: (context) => const NewPatientAppointmentPhone(),
      ),
      tablet: const NewPatientAppointmentPhone(),
      desktop: const NewPatientAppointmentPhone(),
    );
  }
}
