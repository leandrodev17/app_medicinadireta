import 'package:medicinadireta/core/widgets/app_will_pop_scope.dart';
import 'package:medicinadireta/modules/infor_med/presenter/page/infor_med_phone.dart';

import '../../../core/responsive/orientation_layout.dart';
import '../../../core/responsive/screen_type_layout.dart';
import 'package:flutter/material.dart';


class InforMedScreen extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return AppWillPopScope(
      child: ScreenTypeLayout(
        mobile: OrientationLayout(
          portrait: (context) => InforMedPhone(),
          landscape: (context) => InforMedPhone(),
        ),
        tablet: InforMedPhone(),
        desktop: InforMedPhone(),
      ),
    );
  }
}