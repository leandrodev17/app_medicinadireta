import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/modules/new_patient/external/datasource/new_patient_datasource_impl.dart';
import 'package:medicinadireta/modules/new_patient/presenter/controller/new_patient_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class NewPatientBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(NewPatientDatasourceImpl(Get.find<Network>()));
    Get.put(
      NewPatientController(
        newPatient: Get.find<NewPatientDatasourceImpl>(),
      ),
    );
  }
}
