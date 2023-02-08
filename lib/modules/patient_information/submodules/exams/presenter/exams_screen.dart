import 'package:flutter/material.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/presenter/pages/exams_phone.dart';
import '/core/responsive/orientation_layout.dart';
import '/core/responsive/screen_type_layout.dart';



class ExamsScreen extends StatelessWidget {
  const ExamsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => ExamsPhone(),
        landscape: (context) => ExamsPhone(),
      ),
      tablet: ExamsPhone(),
      desktop: ExamsPhone(),
    );
  }
}
