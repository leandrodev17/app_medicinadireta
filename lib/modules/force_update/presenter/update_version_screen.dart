import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:flutter/material.dart';

import 'pages/update_version_phone.dart';

class UpdateVersionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => UpdateVersionPhone(),
        landscape: (context) => UpdateVersionPhone(),
      ),
      tablet: UpdateVersionPhone(),
      desktop: UpdateVersionPhone(),
    );
  }
}
