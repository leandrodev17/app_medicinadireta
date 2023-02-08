import 'package:flutter/material.dart';
import 'package:medicinadireta/modules/patient_information/submodules/pressure/presenter/pages/pressure_phone.dart';
import '/core/responsive/orientation_layout.dart';
import '/core/responsive/screen_type_layout.dart';

class PressureScreen extends StatelessWidget {
  const PressureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => PressurePhone(),
        landscape: (context) => PressurePhone(),
      ),
      tablet: PressurePhone(),
      desktop: PressurePhone(),
    );
  }
}
