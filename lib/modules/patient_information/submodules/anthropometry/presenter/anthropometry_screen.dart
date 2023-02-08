import 'package:flutter/material.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anthropometry/presenter/pages/anthropometry_phone.dart';
import '/core/responsive/orientation_layout.dart';
import '/core/responsive/screen_type_layout.dart';

class AnthropometryScreen extends StatelessWidget {
  const AnthropometryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => AnthropometryPhone(),
        landscape: (context) => AnthropometryPhone(),
      ),
      tablet: AnthropometryPhone(),
      desktop: AnthropometryPhone(),
    );
  }
}
