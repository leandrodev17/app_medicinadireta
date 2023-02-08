import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/modules/modules_helpers/external/datasource/medical_datasource_impl.dart';
import 'package:medicinadireta/modules/modules_helpers/external/datasource/model_to_mail_datasource_impl.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/controller/medical_controller.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/controller/model_to_mail_controller.dart';

class ModelToMailBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(ModelToMailDatasourceImpl(Get.find<Network>()));
    Get.put(MedicalDatasourceImpl(Get.find<Network>()));
    Get.put(CheckConnectingNetwork());
    Get.put(
      ModelToMailController(
        Get.find<ModelToMailDatasourceImpl>(),
      ),
    );
    Get.put(
      MedicalController(
        Get.find<CheckConnectingNetwork>(),
        Get.find<MedicalDatasourceImpl>(),
      ),
    );
  }
}
