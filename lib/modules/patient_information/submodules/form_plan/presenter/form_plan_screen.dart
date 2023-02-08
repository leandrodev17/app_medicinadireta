import 'package:flutter/material.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/presenter/pages/form_plan_phone.dart';
import '/core/responsive/orientation_layout.dart';
import '/core/responsive/screen_type_layout.dart';



class FormPlanScreen extends StatelessWidget {
  const FormPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => FormPlanPhone(),
        landscape: (context) => FormPlanPhone(),
      ),
      tablet: FormPlanPhone(),
      desktop: FormPlanPhone(),
    );
  }
}
