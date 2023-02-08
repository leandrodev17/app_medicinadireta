import 'package:medicinadireta/core/controller_from_initial/force_version_controller.dart';
import 'package:medicinadireta/core/info_app/app_device_info_controller.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/modules/doctor_schedule/external/datasource/doctor_schedule_datasource_impl.dart';
import 'package:medicinadireta/modules/doctor_schedule/presenter/controllers/doctor_schedule_controller.dart';
import 'package:medicinadireta/modules/patient_information/presenter/controller/patient_datails_controller.dart';
import 'package:dio/dio.dart';

import '/core/network/network.dart';
import 'package:get/get.dart';

class DoctorScheduleBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(CheckConnectingNetwork());
    Get.put(AppDeviceInfoController());
    Get.put(PatientDetailsController());
    Get.put(DoctorScheduleDatasourceImpl(Get.find<Network>()));
    Get.put(
      DoctorScheduleController(
        requestServer: Get.find<DoctorScheduleDatasourceImpl>(),
        checkConnecting: Get.find<CheckConnectingNetwork>(),
      ),
    );
    Get.put(
      ForceVersionController(
        network: Get.find<Network>(),
        checkConnecting: Get.find<CheckConnectingNetwork>(),
        deviceInfo: Get.find<AppDeviceInfoController>(),
      ),
    );
  }
}
