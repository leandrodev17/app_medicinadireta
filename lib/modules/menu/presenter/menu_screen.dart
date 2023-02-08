import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/menu/presenter/pages/menu_phone.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => MenuPhone(),
        landscape: (context) => MenuPhone(),
      ),
      tablet: MenuPhone(),
      desktop: MenuPhone(),
    );
  }
}
