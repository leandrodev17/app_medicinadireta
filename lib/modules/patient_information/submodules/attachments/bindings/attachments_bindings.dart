import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/external/datasource/attachements_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/controller/attachments_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/controller/camera_gallery_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AttachmentsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(CameraGalleryController());
    Get.put(Network(Get.find<Dio>()));
    Get.put(AttachmentsDatasourceImpl(Get.find<Network>()));
    Get.put(
      AttachmentsController(
        request: Get.find<AttachmentsDatasourceImpl>(),
        cameraGallery: Get.find<CameraGalleryController>(),
      ),
    );
  }
}
