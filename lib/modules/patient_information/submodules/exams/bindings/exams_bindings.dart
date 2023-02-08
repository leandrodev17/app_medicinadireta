import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/external/datasource/exams_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/presenter/controller/exams_controller.dart';

class ExamsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(CheckConnectingNetwork());
    Get.put(SharedPreferencesHelper());
    Get.put(ExamsDatasourceImpl(Get.find<Network>()));
    Get.put(ExamsController(
      connectingNetwork: Get.find<CheckConnectingNetwork>(),
      request: Get.find<ExamsDatasourceImpl>(),
      sharedPreferencesHelper: Get.find<SharedPreferencesHelper>(),
    ));
  }
}