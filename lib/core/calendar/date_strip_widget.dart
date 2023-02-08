import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';

import 'calendar_strip.dart';

class DateStripWidget extends StatelessWidget {
  static DateTime minDate = DateTime.now().subtract(const Duration(days: 730));
  static DateTime maxDate = DateTime.now().add(const Duration(days: 730));

  final DateTime selectedDate;
  final Function onDateSelected;

  const DateStripWidget({required this.selectedDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    var _year = DateTime.now().year + 30;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 110),
      child: CalendarStrip(
        addSwipeGesture: true,
        containerHeight: 90,
        startDate: minDate,
        endDate: DateTime(_year),
        selectedDate: selectedDate,
        onDateSelected: onDateSelected,
        dateTileBuilder: _dateTileBuilder,
        iconColor: ConstColors.cinza3,
        monthNameWidget: (month) => Container(),
        markedDates: [DateTime.now().add(const Duration(days: 1))],
        // containerDecoration: const BoxDecoration(color: ConstColors.ligtherGrey),
        onWeekSelected: (_) {},
      ),
    );
  }

  Widget _dateTileBuilder(DateTime date, DateTime selectedDate, int rowIndex, String dayName, bool isDateMarked, bool isDateOutOfRange) {
    final bool isSelectedDate = date.compareTo(selectedDate) == 0;

    final normalStyle = GoogleFonts.openSans(color: ConstColors.blue, fontSize: 16.spEx, fontWeight: FontWeight.w700);
    final selectedStyle = GoogleFonts.openSans(color: ConstColors.white, fontSize: 16.spEx, fontWeight: FontWeight.w700);
    final dayNameStyle =
        GoogleFonts.openSans(fontSize: 12.spEx, color: !isSelectedDate ? Color(0xFF656565) : ConstColors.white, fontWeight: FontWeight.w400);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.wEx, vertical: 2.hEx),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: !isSelectedDate ? Colors.transparent : ConstColors.blue,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10.wEx),
        child: Column(
          children: <Widget>[
            Text(dayName.toLowerCase().tr, style: dayNameStyle),
            Text(date.day.toString(), style: !isSelectedDate ? normalStyle : selectedStyle),
            Text(FormatsDatetime.stringMesYearAbbreviation(DateTime(date.year, date.month)), style: dayNameStyle),
          ],
        ),
      ),
    );
  }
}
