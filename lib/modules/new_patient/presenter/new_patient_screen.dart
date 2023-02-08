import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/new_patient/presenter/pages/new_patient_phone.dart';
import 'package:flutter/material.dart';

class NewPatientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => NewPatientPhone(),
        landscape: (context) => NewPatientPhone(),
      ),
      tablet: NewPatientPhone(),
      desktop: NewPatientPhone(),
    );
  }
}
