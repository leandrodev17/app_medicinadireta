import 'package:flutter/material.dart';

import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/pages/medical_phone.dart';


class MedicalRegisterScreen extends StatelessWidget {
  const MedicalRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => MedicalPhone(),
        landscape: (context) => MedicalPhone(),
      ),
      tablet: MedicalPhone(),
      desktop: MedicalPhone(),
    );
  }
}
