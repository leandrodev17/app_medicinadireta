import 'package:flutter/material.dart';

class NavigatorApp {
  NavigatorApp._();

  static openMyPage(BuildContext context, Widget widget, {bool fullscreenDialog = false}) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => widget, fullscreenDialog: fullscreenDialog),
    );
  }
}
