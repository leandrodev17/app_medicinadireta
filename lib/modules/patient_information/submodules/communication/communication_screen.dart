import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/presenter/pages/communication_phone.dart';
import 'package:flutter/material.dart';

class CommunicationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => CommunicationPhone(),
        landscape: (context) => CommunicationPhone(),
      ),
      tablet: CommunicationPhone(),
      desktop: CommunicationPhone(),
    );
  }
}