import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/controller_from_initial/verification_access_menu_user.dart';
import 'package:medicinadireta/core/drawer/page_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_drawer_header.dart';
import 'page_session.dart';

class CustomDrawer extends StatelessWidget {
  final _access = Get.find<VerificationAccessMenuUser>();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(0)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Scaffold(
          body: SafeArea(
            top: true,
            child: Column(
              children: [
                CustomDrawerHeader(_access),
                Divider(color: ConstColors.border),
                Expanded(child: ListView(children: [PageSession(access: _access)])),
                Divider(color: ConstColors.border),
                PageTile(
                  label: 'Sair',
                  iconData: Icons.exit_to_app,
                  onTab: () async => await _access.logout(),
                  highlight: false,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
