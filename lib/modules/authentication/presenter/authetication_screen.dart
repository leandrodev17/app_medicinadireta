import 'package:medicinadireta/modules/authentication/presenter/controllers/authentication_controller.dart';
import 'package:get/get.dart';

import '../../../core/responsive/orientation_layout.dart';
import '../../../core/responsive/screen_type_layout.dart';
import 'package:flutter/material.dart';

import 'pages/authentication_phone.dart';

class AutheticationScreen extends StatelessWidget {
  final _controller = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => AuthenticationPhone(controller: _controller),
        landscape: (context) => AuthenticationPhone(controller: _controller),
      ),
      tablet: AuthenticationPhone(controller: _controller),
      desktop: AuthenticationPhone(controller: _controller),
    );
  }
}
