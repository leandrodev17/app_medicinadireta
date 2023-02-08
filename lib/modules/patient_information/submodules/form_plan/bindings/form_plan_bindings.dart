import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/external/datasource/form_plan_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/presenter/controller/form_plan_controller.dart';

class FormPlanBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(CheckConnectingNetwork());
    Get.put(SharedPreferencesHelper());
    Get.put(FormPlanDatasourceImpl(Get.find<Network>()));
    Get.put(FormPlanController(
      connectingNetwork: Get.find<CheckConnectingNetwork>(),
      request: Get.find<FormPlanDatasourceImpl>(),
      sharedPreferencesHelper: Get.find<SharedPreferencesHelper>(),
    ));
  }
}