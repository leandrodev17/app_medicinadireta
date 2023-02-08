import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/const_colors.dart';

class ItemTitle extends StatelessWidget {
  final String title;
  final bool openCardPatient;
  const ItemTitle({Key? key, required this.title, this.openCardPatient = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: ConstColors.cinza4),
            alignment: Alignment.centerLeft,
            child: Text(
              title.toUpperCase(),
              style: GoogleFonts.openSans(
                color: ConstColors.graphite,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
