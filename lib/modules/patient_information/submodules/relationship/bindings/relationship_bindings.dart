import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/modules/patient/external/datasource/patient_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/external/datasource/relationship_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/presenter/controller/relationship_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RelationshipBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(SharedPreferencesHelper());
    Get.put(Network(Get.find<Dio>()));
    Get.put(RelationshipDatasourceImpl(Get.find<Network>()));
    Get.put(PatientDatasourceImpl(Get.find<Network>()));
    Get.put(
      RelationshipController(
        requestServer: Get.find<RelationshipDatasourceImpl>(),
        sharedPreferences: Get.find<SharedPreferencesHelper>(),
        requestPatient: Get.find<PatientDatasourceImpl>(),
      ),
    );
  }
}