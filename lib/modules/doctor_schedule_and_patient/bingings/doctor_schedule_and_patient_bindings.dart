import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/external/datasource/doctor_schedule_datasource_and_patient_impl.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/presenter/controllers/doctor_schedule_and_patient_controller.dart';
import 'package:dio/dio.dart';

import '/core/network/network.dart';
import 'package:get/get.dart';

class DoctorScheduleAndPatientBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(CheckConnectingNetwork());
    Get.put(DoctorScheduleDatasourceAndPatientImpl(Get.find<Network>()));
    Get.put(
      DoctorScheduleAndPatientController(
        requestServer: Get.find<DoctorScheduleDatasourceAndPatientImpl>(),
        checkConnecting: Get.find<CheckConnectingNetwork>(),
      ),
    );
  }
}
