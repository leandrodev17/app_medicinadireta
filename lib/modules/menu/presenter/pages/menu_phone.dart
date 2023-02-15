import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_drawables.dart';
import 'package:medicinadireta/core/controller_from_initial/verification_access_menu_user.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/menu/presenter/widget/page_session_menu.dart';

class MenuPhone extends StatefulWidget {
  const MenuPhone({Key? key}) : super(key: key);

  @override
  _MenuPhoneState createState() => _MenuPhoneState();
}

class _MenuPhoneState extends State<MenuPhone> with WidgetsBindingObserver {
  final _access = Get.find<VerificationAccessMenuUser>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _access.appDevice();
      _access.dataUserShow();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: ConstColors.backgroundDefault,
      bottomNavigationBar: AppBottomNavigationBar(disableMenu: true),
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: ConstColors.backgroundDefault,
          appBar: AppBarDefault.bar(
              title: Hero(tag: 'menu', child: Image.asset(ConstDrawables.logoSidePath, height: 30.h)), backgroundColor: Colors.white, elevation: 1, toolbarHeight: 55, leadingSizeIcon: 20.h),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2.0, color: const Color(0xFFCACBD7)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.only(left: 8, right: 17, top: 17, bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70.w,
                        height: 70.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Icon(Icons.account_circle, size: 70.h, color: ConstColors.blue),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                              alignment: Alignment.center,
                              color: ConstColors.orange,
                              child: Obx(() {
                                return Container(
                                  child: Text(
                                    _access.infoLogin.value.toUpperCase(),
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w700),
                                  ),
                                );
                              }),
                            ),
                          ),
                          Obx(() {
                            return SizedBox(
                              width: 200.w,
                              child: Text(
                                _access.name.value.toUpperCase(),
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.blue, fontSize: 14.sp, fontWeight: FontWeight.w700),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      PageSessionMenu(accessMenuUser: _access),
                      Container(padding: const EdgeInsets.symmetric(vertical: 10), child: const Divider()),
                      Obx(
                        () {
                          return Text(
                            'Versão: ${_access.versionApp}',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.greyCard, fontSize: 11.sp, fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
