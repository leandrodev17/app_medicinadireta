import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/presenter/pages/evolution_phone.dart';
import 'package:flutter/material.dart';

class EvolutionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => EvolutionPhone(),
        landscape: (context) => EvolutionPhone(),
      ),
      tablet: EvolutionPhone(),
      desktop: EvolutionPhone(),
    );
  }
}