import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_drawables.dart';
import 'package:medicinadireta/core/controller_from_initial/verification_access_menu_user.dart';
import 'package:medicinadireta/core/menu/item_menu.dart';
import 'package:medicinadireta/core/menu/model/item_submenu_model.dart';
import 'package:medicinadireta/routes/app_pages.dart';

class PageSessionMenu extends StatefulWidget {
  final VerificationAccessMenuUser accessMenuUser;
  const PageSessionMenu({Key? key, required this.accessMenuUser}) : super(key: key);

  @override
  State<PageSessionMenu> createState() => _PageSessionMenuState();
}

class _PageSessionMenuState extends State<PageSessionMenu> {
  bool visibleClinical = false;

  @override
  void initState() {
    visibleClinical = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(height: 5),
      ItemMenu(
        showItem: false,
        visiblePrimary: true,
        leadingPrimary: const Icon(ConstDrawables.appIconDateRangeOutlined, color: ConstColors.blue, size: 24),
        onTapPrimary: () => Get.toNamed(Routes.DOCTOR_ACHEDULE),
        titlePrimary: 'schedule'.tr.toUpperCase(),
        trailingColorPrimary: ConstColors.orange,
      ),
      const SizedBox(height: 5),
      ItemMenu(
        showItem: false,
        visiblePrimary: true,
        leadingPrimary: const Icon(ConstDrawables.appIconPersonSearchOutlined, color: ConstColors.blue, size: 24),
        onTapPrimary: () => Get.toNamed(Routes.LIST_PATIENT),
        titlePrimary: 'patients'.tr.toUpperCase(),
        trailingColorPrimary: ConstColors.orange,
      ),
      const SizedBox(height: 5),
      ItemMenu(
        showItem: false,
        visiblePrimary: true,
        leadingPrimary: const Icon(ConstDrawables.appIconAttachMoneyOutlined, color: ConstColors.blue, size: 24),
        onTapPrimary: () => Get.toNamed(Routes.FINANCIAL),
        titlePrimary: 'financial'.tr.toUpperCase(),
        trailingColorPrimary: ConstColors.orange,
      ),
      const SizedBox(height: 5),
      ItemMenu(
        showItem: visibleClinical,
        visiblePrimary: true,
        leadingPrimary: const Icon(ConstDrawables.appIconMedicalInformation, color: ConstColors.blue, size: 24),
        onTapPrimary: () => setState(() => visibleClinical = !visibleClinical),
        titlePrimary: 'Área Clínica'.tr.toUpperCase(),
        trailingColorPrimary: ConstColors.orange,
        itens: [
          ItemSubmenuModel(
            visible: widget.accessMenuUser.existsKeyMenu(Routes.drugRegistration),
            title: 'Cadastro de Medicamento'.toUpperCase(),
            onTap: () async => await Get.toNamed(Routes.drugRegistration),
          ),
        ],
      ),
      const SizedBox(height: 5),
      ItemMenu(
        showItem: false,
        visiblePrimary: true,
        leadingPrimary: const Icon(ConstDrawables.appIconSettingsSuggestOutlined, color: ConstColors.blue, size: 24),
        onTapPrimary: () => Get.toNamed(Routes.PANEL_CONTROL),
        titlePrimary: 'control_panel'.tr.toUpperCase(),
        trailingColorPrimary: ConstColors.orange,
      ),
      const SizedBox(height: 5),
      ItemMenu(
        showItem: false,
        visiblePrimary: true,
        leadingPrimary: const Icon(ConstDrawables.appIconSettingsSuggestOutlined, color: ConstColors.blue, size: 24),
        onTapPrimary: () => Get.toNamed(Routes.INFOR_MED),
        titlePrimary: 'InforMed'.tr.toUpperCase(),
        trailingColorPrimary: ConstColors.orange,
        iconDataImage: ConstDrawables.informed,
      ),
      const SizedBox(height: 5),
      ItemMenu(
        showItem: false,
        visiblePrimary: true,
        leadingPrimary: const Icon(ConstDrawables.appIconLogoutOutlined, color: ConstColors.blue, size: 24),
        onTapPrimary: () async => await widget.accessMenuUser.logout(),
        titlePrimary: 'logout'.tr.toUpperCase(),
        trailingColorPrimary: ConstColors.white,
        backgroundItem: ConstColors.orange,
        colorIconLeading: ConstColors.white,
        colorTextLeading: ConstColors.white,
      ),
    ]);
  }
}
