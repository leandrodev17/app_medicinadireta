import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/external/datasource/evolution_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/presenter/controller/evolution_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/presenter/controller/form_evolution_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class EvolutionBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(SharedPreferencesHelper());
    Get.put(CheckConnectingNetwork());
    Get.put(EvolutionDatasourceImpl(Get.find<Network>()));
    Get.put(
      EvolutionController(
        connecting: Get.find<CheckConnectingNetwork>(),
        request: Get.find<EvolutionDatasourceImpl>(),
        shared: Get.find<SharedPreferencesHelper>(),
      ),
    );
    Get.put(
      FormEvolutionController(
        request: Get.find<EvolutionDatasourceImpl>(),
        shared: Get.find<SharedPreferencesHelper>(),
        evolutionController: Get.find<EvolutionController>(),
      ),
    );
  }
}
