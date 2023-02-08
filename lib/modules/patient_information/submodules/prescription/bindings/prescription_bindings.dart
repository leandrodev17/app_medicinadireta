import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/external/datasource/prescription_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/presenter/controller/prescription_controller.dart';

class PrescriptionBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(CheckConnectingNetwork());
    Get.put(SharedPreferencesHelper());
    Get.put(PrescriptionDatasourceImpl(Get.find<Network>()));
    Get.put(PrescriptionController(
      connectingNetwork: Get.find<CheckConnectingNetwork>(),
      request: Get.find<PrescriptionDatasourceImpl>(),
      sharedPreferencesHelper: Get.find<SharedPreferencesHelper>(),
    ));
  }
}