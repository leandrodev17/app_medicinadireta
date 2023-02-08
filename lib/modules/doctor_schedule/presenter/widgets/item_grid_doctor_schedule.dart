import 'package:google_fonts/google_fonts.dart';
import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';

class ItemGridDoctorSchedule extends StatelessWidget {
  final String label;
  final VoidCallback onTab;
  final EdgeInsets? contentPadding;
  const ItemGridDoctorSchedule({Key? key, required this.label, required this.onTab, this.contentPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding ?? EdgeInsets.zero,
      dense: false,
      title: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: ConstColors.scheduleGridColorText,
        ),
      ),
      onTap: onTab,
    );
  }
}
