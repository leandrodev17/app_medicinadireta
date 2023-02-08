import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/pages/doctor_commitment_phone.dart';

import 'package:flutter/material.dart';

class DoctorCommitmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => DoctorCommitmentPhone(),
        landscape: (context) => DoctorCommitmentPhone(),
      ),
      tablet: DoctorCommitmentPhone(),
      desktop: DoctorCommitmentPhone(),
    );
  }
}
