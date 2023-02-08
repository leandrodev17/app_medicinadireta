import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/external/datasource/anamnese_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/presenter/controller/anamnese_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AnamneseBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(CheckConnectingNetwork());
    Get.put(AnamneseDatasourceImpl(Get.find<Network>()));
    Get.put(AnamneseController(
      connectingNetwork: Get.find<CheckConnectingNetwork>(),
      request: Get.find<AnamneseDatasourceImpl>(),
    ));
  }
}
