import 'package:flutter/material.dart';

class AppWillPopScope extends StatelessWidget {
  final Widget child;
  final Future<bool> Function()? onWillPop;
  AppWillPopScope({Key? key, required this.child, this.onWillPop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop ?? () async => await Future.value(false),
      child: child,
    );
  }
}
