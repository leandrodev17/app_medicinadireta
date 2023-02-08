import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/modules/doctor_schedule/external/datasource/doctor_schedule_datasource_impl.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/external/datasource/doctor_commitment_datasource_impl.dart';
import 'package:medicinadireta/modules/reschedule_committed/external/reschedule_datasource_impl.dart';
import 'package:medicinadireta/modules/reschedule_committed/presenter/controller/reschedule_committed_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ReschuduleCommitted implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(CheckConnectingNetwork());
    Get.put(RescheduleDatasourceImpl(Get.find<Network>()));
    Get.put(DoctorScheduleDatasourceImpl(Get.find<Network>()));
    Get.put(DoctorCommitmentDatasourceImpl(Get.find<Network>()));
    
    Get.put(RescheduleCommittedController(
      saveReschedule: Get.find<RescheduleDatasourceImpl>(),
      connecting: Get.find<CheckConnectingNetwork>(),
      listSchedule: Get.find<DoctorScheduleDatasourceImpl>(),
      listDoctorCommitment: Get.find<DoctorCommitmentDatasourceImpl>(),
    ));
  }
}
