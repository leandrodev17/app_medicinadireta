import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/controller_from_initial/verification_access_menu_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawerHeader extends StatelessWidget {
  final VerificationAccessMenuUser user;
  const CustomDrawerHeader(this.user, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[100],
            radius: 40,
            child: Obx(() {
              return Text(
                user.avatar.toString(),
                style: Theme.of(context).textTheme.subtitle1?.copyWith(color: ConstColors.orange, fontSize: 30, fontWeight: FontWeight.w900),
              );
            }),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Text(
                    user.name.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
