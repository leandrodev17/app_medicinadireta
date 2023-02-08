import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/helpers/helpers.dart';
import 'package:medicinadireta/core/validators/validators.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'i_push_strategy.dart';

class OpenLinkStrategy implements IPushStrategy {
  @override
  void execute(Map<String, dynamic> pushPayload) async {
    if (pushPayload.isNotEmpty) {
      var _body = pushPayload['message'] ?? '--';
      var _title = pushPayload['title'] ?? '--';
      var _href = pushPayload['href'] ?? '--';
      var _confirmButton = pushPayload['confirmButton'] ?? null;
      var _cancelButton = pushPayload['cancelButton'] ?? null;

      void openDialog() async {
        Navigator.push<void>(
          Get.context!,
          MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  ShowLinkNotification(buttonPrimary: _confirmButton, buttonSecondary: _cancelButton, body: _body, title: _title, linkExternal: _href),
              fullscreenDialog: true),
        );
      }

      openDialog();
    }
  }
}

class ShowLinkNotification extends StatelessWidget {
  final String? buttonPrimary;
  final String? buttonSecondary;
  final String? body;
  final String? title;
  final String? linkExternal;
  const ShowLinkNotification({Key? key, this.buttonPrimary, this.buttonSecondary, this.body, this.title, this.linkExternal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style1 = TextStyle(fontSize: 24, color: ConstColors.colorText, fontWeight: FontWeight.w500);
    final _style2 = TextStyle(fontSize: 20, color: ConstColors.colorText, fontWeight: FontWeight.w400);
    final _style3 = TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400);

    var _isURL = validatorRegex.url(linkExternal!);

    return AppScaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault.bar(
        onPressedLeading: () => Get.back(),
        title: Text('Comunicado!'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(17),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(title ?? '--', style: _style1, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(body ?? '--', style: _style2, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              AppButton(
                onPressed: _isURL ? () async => Helpers.launchURLOpenLink(linkExternal ?? '') : null,
                childRaisedButton: Text('Abrir', style: _style3),
                colorBackground: ConstColors.blue,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
