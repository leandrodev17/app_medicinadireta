import '../../../../lang/app_translation.dart';

import '../../../../constants/const_drawables.dart';

import '../controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPhone extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(tag: 'logo', child: Image.asset(ConstDrawables.logo, height: 130)),
            Container(padding: const EdgeInsets.symmetric(vertical: 10), child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 1))),
            AppTranslationWidget(text: 'awaitFromAuthenticationOrHome'),
          ],
        ),
      ),
    );
  }
}
