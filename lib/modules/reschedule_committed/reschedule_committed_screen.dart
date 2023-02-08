import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/reschedule_committed/presenter/pages/reschedule/view_reschedule.dart';
import 'package:flutter/material.dart';

class RescheduleCommittedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => ViewReschedule(),
        landscape: (context) => ViewReschedule(),
      ),
      tablet: ViewReschedule(),
      desktop: ViewReschedule(),
    );
  }
}
