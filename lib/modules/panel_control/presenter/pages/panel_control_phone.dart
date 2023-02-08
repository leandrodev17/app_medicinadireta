import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/drawer/page_tile.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/routes/app_pages.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanelControlPhone extends StatefulWidget {
  PanelControlPhone({Key? key}) : super(key: key);

  @override
  _PanelControlPhoneState createState() => _PanelControlPhoneState();
}

class _PanelControlPhoneState extends State<PanelControlPhone> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      onWillPop: () async => await Future.value(true),
      backgroundColor: ConstColors.backgroundDefault,
      bottomNavigationBar: AppBottomNavigationBar(),
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: ConstColors.backgroundDefault,
          appBar: AppBarDefault.bar(titleApp: 'control_panel'),
          body: ResponsiveBuilder(builder: (context, view) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedFromColumn(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
                      child: PageTile(
                        label: 'Mudar Senha',
                        iconData: Icons.vpn_key_outlined,
                        onTab: () async => await Get.toNamed(Routes.CHANGE_PASSWORD),
                        highlight: true,
                      )),
                  Container(
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
                      child: PageTile(
                        label: 'Suporte',
                        iconData: Icons.help_outlined,
                        onTab: () async => await Get.toNamed(Routes.SUPPORT),
                        highlight: true,
                      )),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
