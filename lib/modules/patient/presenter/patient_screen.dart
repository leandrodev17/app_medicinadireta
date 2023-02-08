import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/patient/presenter/pages/patient_phone.dart';
import 'package:flutter/material.dart';

class PatientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => PatientPhone(),
        landscape: (context) => PatientPhone(),
      ),
      tablet: PatientPhone(),
      desktop: PatientPhone(),
    );
  }
}
