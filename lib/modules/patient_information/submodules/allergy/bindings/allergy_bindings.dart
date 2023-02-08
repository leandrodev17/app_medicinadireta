import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/external/datasource/allergy_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/presenter/controller/allergy_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AllergyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(CheckConnectingNetwork());
    Get.put(SharedPreferencesHelper());
    Get.put(AllergyDatasourceImpl(Get.find<Network>()));
    Get.put(AllergyController(
      connectingNetwork: Get.find<CheckConnectingNetwork>(),
      request: Get.find<AllergyDatasourceImpl>(),
      sharedPreferencesHelper: Get.find<SharedPreferencesHelper>(),
    ));
  }
}
