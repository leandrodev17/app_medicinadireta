import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/presenter/pages/medicine_in_use_phone.dart';
import 'package:flutter/material.dart';

class MedicinesInUseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => MedicineInUsePhone(),
        landscape: (context) => MedicineInUsePhone(),
      ),
      tablet: MedicineInUsePhone(),
      desktop: MedicineInUsePhone(),
    );
  }
}
