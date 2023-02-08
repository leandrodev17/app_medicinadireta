import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/new_medical_appointment/presenter/pages/list_patient_appointment_phone.dart';
import 'package:flutter/material.dart';

class ListPatientAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => ListPatientAppointmentPhone(),
        landscape: (context) => ListPatientAppointmentPhone(),
      ),
      tablet: ListPatientAppointmentPhone(),
      desktop: ListPatientAppointmentPhone(),
    );
  }
}
