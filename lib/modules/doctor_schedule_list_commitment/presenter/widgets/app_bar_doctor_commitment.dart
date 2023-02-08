import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/controllers/doctor_commitment_controller.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget appBarDoctorCommitment(
  BuildContext context,
  DoctorCommitmentController controller, {
  required String nameDoctor,
  Function()? onSelectCalendar,
  Function()? onPressedAppointment,
}) {
  return AppBar(
    titleSpacing: 0,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    leading: IconButton(icon: const Icon(Icons.arrow_back, size: 30), onPressed: () => Get.toNamed(Routes.DOCTOR_ACHEDULE), color: ConstColors.graphite),
    actions: <Widget>[
      IconButton(icon: const Icon(Icons.calendar_today), onPressed: onSelectCalendar),
    ],
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'schedule_of_the_day'.tr,
          style: GoogleFonts.openSans(color: ConstColors.graphite, fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ],
    ),
  );
}
