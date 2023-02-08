import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../anthropometry/external/datasource/anthropometry_datasource_impl.dart';
import '../presenter/controller/anthropometry_controller.dart';

class AnthropometryBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(CheckConnectingNetwork());
    Get.put(SharedPreferencesHelper());
    Get.put(AnthropometryDatasourceImpl(Get.find<Network>()));
    Get.put(AnthropometryController(
      connectingNetwork: Get.find<CheckConnectingNetwork>(),
      request: Get.find<AnthropometryDatasourceImpl>(),
      sharedPreferencesHelper: Get.find<SharedPreferencesHelper>(),
    ));
  }
}
