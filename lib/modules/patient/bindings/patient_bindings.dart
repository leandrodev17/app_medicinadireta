import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/modules/patient/external/datasource/patient_datasource_impl.dart';
import 'package:medicinadireta/modules/patient/presenter/controller/patient_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PatientBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(PatientDatasourceImpl(Get.find<Network>()));
    Get.put(
      PatientController(
        request: Get.find<PatientDatasourceImpl>(),
      ),
    );
  }
}
