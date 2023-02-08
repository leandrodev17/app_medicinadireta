import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/const_colors.dart';

class ItemOBS extends StatelessWidget {
  final String obs;
  final bool openCardPatient;
  const ItemOBS({Key? key, required this.obs, this.openCardPatient = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 26,
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: ConstColors.observationColorText),
            alignment: Alignment.center,
            child: Text(
              'obs'.toUpperCase(),
              style: GoogleFonts.openSans(
                color: ConstColors.observationColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: ConstColors.cinza4),
              alignment: Alignment.centerLeft,
              child: Text(
                obs.toUpperCase(),
                style: GoogleFonts.openSans(
                  color: ConstColors.graphite,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ).copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: openCardPatient ? 10 : 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
