import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:dio/dio.dart';

import '/core/network/network.dart';
import '/core/shared/shared_preferences.dart';
import '/modules/authentication/external/datasource/authentication_datasource_impl.dart';
import 'package:get/get.dart';
import '../presenter/controllers/authentication_controller.dart';

class AutheticationBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(SharedPreferencesHelper());
    Get.put(CheckConnectingNetwork());
    Get.put(Network(Get.find<Dio>()));
    Get.put(AuthenticationDatasourceImpl(Get.find<Network>()));
    Get.put(
      AuthenticationController(
        requestServer: Get.find<AuthenticationDatasourceImpl>(),
        sharedPreferences: Get.find<SharedPreferencesHelper>(),
        checkConnecting: Get.find<CheckConnectingNetwork>(),
      ),
    );
  }
}
