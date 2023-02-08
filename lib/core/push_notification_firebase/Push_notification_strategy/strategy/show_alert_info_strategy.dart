import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'i_push_strategy.dart';

class ShowAlertInfoStrategy implements IPushStrategy {
  @override
  Future<void> execute(Map<String, dynamic> pushPayload) async {
    print("pushPayload : $pushPayload");
    if (pushPayload.isNotEmpty) {
      var _body = pushPayload['message'] ?? '--';
      var _title = pushPayload['title'] ?? '--';

      void openDialog() async {
        Navigator.push<void>(
          Get.context!,
          MaterialPageRoute<void>(builder: (BuildContext context) => ShowInfoNotification(body: _body, title: _title), fullscreenDialog: true),
        );
      }

      openDialog();
    }
  }
}

class ShowInfoNotification extends StatelessWidget {
  final String? body;
  final String? title;
  const ShowInfoNotification({Key? key, this.body, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style1 = TextStyle(fontSize: 24, color: ConstColors.colorText, fontWeight: FontWeight.w600);
    final _style2 = TextStyle(fontSize: 20, color: ConstColors.colorText, fontWeight: FontWeight.w400);
    return AppScaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault.bar(
        onPressedLeading: () => Get.back(),
        title:Text('Comunicado!'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title ?? '--', style: _style1, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(body ?? '--', style: _style2, textAlign: TextAlign.center),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
