import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/validators/validators.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

import 'i_push_strategy.dart';

class ShowAlertImageStrategy implements IPushStrategy {
  @override
  Future<void> execute(Map<String, dynamic> pushPayload) async {
    if (pushPayload.isNotEmpty) {
      var _body = pushPayload['message'] ?? '--';
      var _title = pushPayload['title'] ?? '--';
      var _href = pushPayload['href'] ?? '--';

      void openDialog() async {
        Navigator.push<void>(
          Get.context!,
          MaterialPageRoute<void>(builder: (BuildContext context) => ShowImageNotification(path: _href, body: _body, title: _title), fullscreenDialog: true),
        );
      }
      openDialog();
    }
  }
}

class ShowImageNotification extends StatelessWidget {
  final String? path;
  final String? body;
  final String? title;
  const ShowImageNotification({Key? key, this.path, this.body, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style1 = TextStyle(fontSize: 24, color: ConstColors.colorText, fontWeight: FontWeight.w500);
    final _style2 = TextStyle(fontSize: 20, color: ConstColors.colorText, fontWeight: FontWeight.w400);

    var _isURL = validatorRegex.url(path!);

    return AppScaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault.bar(
        onPressedLeading: () => Get.back(),
        title: Text('Comunicado!'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                 const SizedBox(height: 10),
                Text(title ?? '--', style: _style1, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text(body ?? '--', style: _style2, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                Visibility(
                  visible: !_isURL,
                  child: Text('Oops! não foi possível carregar a imagem.', style: _style1, textAlign: TextAlign.center),
                ),
                Visibility(
                  visible: _isURL,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: path!,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
