import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/panel_control/presenter/pages/panel_control_phone.dart';
import 'package:flutter/material.dart';

class PanelControlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => PanelControlPhone(),
        landscape: (context) => PanelControlPhone(),
      ),
      tablet: PanelControlPhone(),
      desktop: PanelControlPhone(),
    );
  }
}
