import 'package:flutter/material.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/presenter/pages/prescription_phone.dart';
import '/core/responsive/orientation_layout.dart';
import '/core/responsive/screen_type_layout.dart';



class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => PrescriptionPhone(),
        landscape: (context) => PrescriptionPhone(),
      ),
      tablet: PrescriptionPhone(),
      desktop: PrescriptionPhone(),
    );
  }
}
