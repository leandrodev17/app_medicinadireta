import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/modules/patient/external/datasource/patient_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/external/datasource/communication_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/presenter/controller/communication_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CommunicationBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(CommunicationDatasourceImpl(Get.find<Network>()));
    Get.put(PatientDatasourceImpl(Get.find<Network>()));
    Get.put(
      CommunicationController(
        request: Get.find<CommunicationDatasourceImpl>(),
        requestPatient: Get.find<PatientDatasourceImpl>(),
      ),
    );
  }
}
