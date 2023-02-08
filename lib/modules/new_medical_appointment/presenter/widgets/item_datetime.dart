import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/const_colors.dart';
import '../controller/new_medical_appointment_controller.dart';

class ItemDatetime extends StatelessWidget {
  final NewMedicalAppointmentController controller;

  final String time;
  final String datetime;
  final bool isSnap;
  const ItemDatetime({Key? key, required this.controller, required this.time, required this.datetime, this.isSnap = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: ConstColors.backgroundDefault),
              child: const Icon(Icons.event_note, size: 35, color: ConstColors.blue),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                      text: 'Data: ',
                      style: GoogleFonts.openSans(color: const Color(0xFF284066), fontSize: 16, fontWeight: FontWeight.w300),
                      children: [
                        TextSpan(
                          text: datetime.toString(),
                          style: GoogleFonts.openSans(color: ConstColors.ff284066, fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                      text: 'Horário: ',
                      style: GoogleFonts.openSans(color: const Color(0xFF656565), fontSize: 16, fontWeight: FontWeight.w300),
                      children: [
                        TextSpan(
                          text: time.toString(),
                          style: GoogleFonts.openSans(color: ConstColors.ff284066, fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: isSnap ? () async => await controller.showDatePickerData() : () => Navigator.pop(context),
                icon: const Icon(
                  Icons.edit,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }
}
