import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/pages/list_appointment_phone.dart';
import 'package:flutter/material.dart';

class ListAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => ListAppointmentPhone(),
        landscape: (context) => ListAppointmentPhone(),
      ),
      tablet: ListAppointmentPhone(),
      desktop: ListAppointmentPhone(),
    );
  }
}
