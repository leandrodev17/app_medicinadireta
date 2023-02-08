import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/network/network_info_med.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/modules/infor_med/external/datasource/info_med_datasource_impl.dart';
import 'package:medicinadireta/modules/infor_med/presenter/controller/infor_med_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class InforMedBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SharedPreferencesHelper());
    Get.put(CheckConnectingNetwork());
    Get.put(Dio());
    Get.put(NetworkInfoMed(Get.find<Dio>()));
    Get.put(InfoMedDatasourceImpl(Get.find<NetworkInfoMed>()));
    Get.put(InforMedController(
      datasourceImpl: Get.find<InfoMedDatasourceImpl>(),
      sharedPreferences: Get.find<SharedPreferencesHelper>(),
      checkConnecting: Get.find<CheckConnectingNetwork>(),
    ));
  }
}
