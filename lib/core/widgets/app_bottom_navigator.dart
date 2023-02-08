import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final bool disablePatient;
  final bool disableMenu;
  final bool disableSchedule;
  const AppBottomNavigationBar({Key? key, this.disableSchedule = false, this.disableMenu = false, this.disablePatient = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 60.hEx,
      decoration: const BoxDecoration(
        color: Color(0xff0C2D59),
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              offset: Offset(5.0, 5.0), //Offset
              blurRadius: 10.0,
              spreadRadius: 2.0), //BoxShadow
          BoxShadow(color: Colors.white, offset: Offset(0.0, 0.0), blurRadius: 0.0, spreadRadius: 0.0), //BoxShadow
        ],
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 60.hEx,
        color: const Color(0xffF5F5F5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: _item(
                  context: context,
                  icon: Icons.person_search_outlined,
                  colorActive: disablePatient ? ConstColors.white : ConstColors.blue,
                  colorActiveBackground: disablePatient ? ConstColors.blue : ConstColors.white,
                  title: 'patients',
                  onPressed: () async {
                    if (!disablePatient) await Get.toNamed(Routes.LIST_PATIENT);
                  }),
            ),
            Expanded(
              child: _item(
                  context: context,
                  icon: Icons.menu_outlined,
                  colorActive: disableMenu ? ConstColors.white : ConstColors.blue,
                  colorActiveBackground: disableMenu ? ConstColors.blue : ConstColors.white,
                  title: 'menu',
                  onPressed: () async {
                    if (!disableMenu) await Get.toNamed(Routes.MENU);
                  }),
            ),
            Expanded(
              child: _item(
                  context: context,
                  icon: Icons.date_range_outlined,
                  colorActive: disableSchedule ? ConstColors.white : ConstColors.blue,
                  colorActiveBackground: disableSchedule ? ConstColors.blue : ConstColors.white,
                  title: 'schedule',
                  onPressed: () async {
                    if (!disableSchedule) await Get.toNamed(Routes.DOCTOR_ACHEDULE);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _item({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Function()? onPressed,
    required Color colorActive,
    required Color colorActiveBackground,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 65.hEx,
        color: colorActiveBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 22.wEx,
              height: 20.hEx,
              child: InkWell(
                onTap: onPressed,
                child: Icon(icon, color: colorActive),
              ),
            ),
            SizedBox(height: 3.hEx),
            Text(
              title.tr.toUpperCase(),
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontSize: 12.spEx,
                    color: colorActive,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
