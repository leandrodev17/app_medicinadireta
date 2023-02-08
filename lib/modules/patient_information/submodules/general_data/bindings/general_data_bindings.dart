import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/modules/modules_helpers/external/datasource/model_to_mail_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/controller/camera_gallery_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/external/datasource/general_data_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/presenter/controller/general_data_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class GeneralDataBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(SharedPreferencesHelper());
    Get.put(CameraGalleryController());
    Get.put(GeneralDataDatasourceImpl(Get.find<Network>()));
    Get.put(ModelToMailDatasourceImpl(Get.find<Network>()));
    Get.put(
      GeneralDataController(
        request: Get.find<GeneralDataDatasourceImpl>(),
        newPhone: Get.find<ModelToMailDatasourceImpl>(),
        shared: Get.find<SharedPreferencesHelper>(),
        cameraGallery: Get.find<CameraGalleryController>(),
      ),
    );
  }
}
