import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUnfocus {
  AppUnfocus._();
  static void nextFocus({required FocusNode unfocus, required FocusNode nextFocus}) {
    unfocus.unfocus();
    FocusScope.of(Get.context!).requestFocus(nextFocus);
  }
}
