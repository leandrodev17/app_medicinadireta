import 'package:medicinadireta/core/widgets/app_will_pop_scope.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/presenter/pages/doctor_schedule_and_patient_phone.dart';

import '../../../core/responsive/orientation_layout.dart';
import '../../../core/responsive/screen_type_layout.dart';
import 'package:flutter/material.dart';


class DoctorSchedulePatientScreen extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return AppWillPopScope(
      child: ScreenTypeLayout(
        mobile: OrientationLayout(
          portrait: (context) => DoctorScheduleAndPatientPhone(),
          landscape: (context) => DoctorScheduleAndPatientPhone(),
        ),
        tablet: DoctorScheduleAndPatientPhone(),
        desktop: DoctorScheduleAndPatientPhone(),
      ),
    );
  }
}