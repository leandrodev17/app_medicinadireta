import '../../../core/responsive/orientation_layout.dart';
import '../../../core/responsive/screen_type_layout.dart';
import 'package:flutter/material.dart';
import 'pages/splash_phone.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => SplashPhone(),
        landscape: (context) => SplashPhone(),
      ),
      tablet: SplashPhone(),
      desktop: SplashPhone(),
    );
  }
}
