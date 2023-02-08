import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/external/datasource/medicines_in_use_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/presenter/controller/medicine_in_use_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MedicineInUseBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(MedicinesInUseDatasourceImpl(Get.find<Network>()));
    Get.put(
      MedicineInUseController(
        Get.find<MedicinesInUseDatasourceImpl>(),
      ),
    );
  }
}
