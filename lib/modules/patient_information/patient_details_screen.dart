import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/patient_information/presenter/pages/patient_details_phone.dart';
import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => PatientDetailsPhone(),
        landscape: (context) => PatientDetailsPhone(),
      ),
      tablet: PatientDetailsPhone(),
      desktop: PatientDetailsPhone(),
    );
  }
}
