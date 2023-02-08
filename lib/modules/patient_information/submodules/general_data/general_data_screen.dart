import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/presenter/pages/general_data_phone.dart';
import 'package:flutter/material.dart';

class GeneralDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => GeneralDataPhone(),
        landscape: (context) => GeneralDataPhone(),
      ),
      tablet: GeneralDataPhone(),
      desktop: GeneralDataPhone(),
    );
  }
}
