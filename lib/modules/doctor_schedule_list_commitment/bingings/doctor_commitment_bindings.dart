import 'package:medicinadireta/core/binding_from_initial/commons_controller.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/external/datasource/doctor_commitment_datasource_impl.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/controllers/doctor_commitment_controller.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/controllers/list_appointment_controller.dart';
import 'package:dio/dio.dart';

import '/core/network/network.dart';
import '/core/shared/shared_preferences.dart';
import 'package:get/get.dart';

class DoctorCommitmentBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(CommonsController());
    Get.put(Network(Get.find<Dio>()));
    Get.put(SharedPreferencesHelper());
    Get.put(CheckConnectingNetwork());
    Get.put(DoctorCommitmentDatasourceImpl(Get.find<Network>()));
    Get.put(
      DoctorCommitmentController(
        requestServer: Get.find<DoctorCommitmentDatasourceImpl>(),
        sharedPreferences: Get.find<SharedPreferencesHelper>(),
        checkConnecting: Get.find<CheckConnectingNetwork>(),
        commons: Get.find<CommonsController>(),
      ),
    );
    Get.put(
      ListAppointmentController(
        requestServer: Get.find<DoctorCommitmentDatasourceImpl>(),
        sharedPreferences: Get.find<SharedPreferencesHelper>(),
        checkConnecting: Get.find<CheckConnectingNetwork>(),
      ),
    );
  }
}
