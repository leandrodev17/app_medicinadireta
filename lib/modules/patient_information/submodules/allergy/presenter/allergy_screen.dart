import 'package:flutter/material.dart';
import '/core/responsive/orientation_layout.dart';
import '/core/responsive/screen_type_layout.dart';
import '/modules/patient_information/submodules/allergy/presenter/pages/allergy_phone.dart';

class AllergyScreen extends StatelessWidget {
  const AllergyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => AllergyPhone(),
        landscape: (context) => AllergyPhone(),
      ),
      tablet: AllergyPhone(),
      desktop: AllergyPhone(),
    );
  }
}
