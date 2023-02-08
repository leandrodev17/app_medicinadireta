import 'package:medicinadireta/core/controller_from_initial/verification_access_menu_user.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'page_tile.dart';

class PageSession extends StatelessWidget {
  final VerificationAccessMenuUser access;

  const PageSession({Key? key, required this.access}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CustomDrawerHeader(),
        if (access.existsKeyMenu(Routes.DOCTOR_ACHEDULE))
          PageTile(
              label: 'Agenda',
              iconData: Icons.calendar_today,
              onTab: () async {
                Get.back();
                await Get.toNamed(Routes.DOCTOR_ACHEDULE);
              },
              highlight: true),
        if (access.existsKeyMenu(Routes.LIST_PATIENT))
          PageTile(
              label: 'Pacientes',
              iconData: Icons.person,
              onTab: () async {
                Get.back();
                await Get.toNamed(Routes.LIST_PATIENT);
              },
              highlight: false),
        if (access.existsKeyMenu(Routes.FINANCIAL))
          PageTile(
              label: 'Financeiro',
              iconData: Icons.monetization_on,
              onTab: () async {
                Get.back();
                await Get.toNamed(Routes.FINANCIAL);
              },
              highlight: false),
        if (access.existsKeyMenu(Routes.PANEL_CONTROL))
          PageTile(
              label: 'Painel de Controle',
              iconData: Icons.settings,
              onTab: () async {
                Get.back();
                await Get.toNamed(Routes.PANEL_CONTROL);
              },
              highlight: false),
      ],
    );
  }
}
