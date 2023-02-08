import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/new_medical_appointment/presenter/pages/new_medical_appointment_phone.dart';
import 'package:flutter/material.dart';

class SnapMedicalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => NewMedicalAppointmentPhone(),
        landscape: (context) => NewMedicalAppointmentPhone(),
      ),
      tablet: NewMedicalAppointmentPhone(),
      desktop: NewMedicalAppointmentPhone(),
    );
  }
}