import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../pressure/external/datasource/pressure_datasource_impl.dart';
import '../presenter/controller/pressure_controller.dart';

class PressureBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(CheckConnectingNetwork());
    Get.put(SharedPreferencesHelper());
    Get.put(PressureDatasourceImpl(Get.find<Network>()));
    Get.put(PressureController(
      connectingNetwork: Get.find<CheckConnectingNetwork>(),
      request: Get.find<PressureDatasourceImpl>(),
      sharedPreferencesHelper: Get.find<SharedPreferencesHelper>(),
    ));
  }
}
