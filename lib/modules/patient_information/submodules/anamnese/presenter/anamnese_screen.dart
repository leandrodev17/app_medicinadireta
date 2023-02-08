import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/presenter/pages/anamnese_phone.dart';
import 'package:flutter/material.dart';

class AnamneseScreen extends StatelessWidget {
  const AnamneseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => AnamnesePhone(),
        landscape: (context) => AnamnesePhone(),
      ),
      tablet: AnamnesePhone(),
      desktop: AnamnesePhone(),
    );
  }
}
