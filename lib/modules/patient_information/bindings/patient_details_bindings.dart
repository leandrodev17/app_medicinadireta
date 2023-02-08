import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:medicinadireta/core/controller_from_initial/verification_access_menu_user.dart';
import 'package:medicinadireta/core/info_app/app_device_info_controller.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/modules/modules_helpers/external/datasource/model_to_mail_datasource_impl.dart';
import 'package:medicinadireta/modules/patient/external/datasource/patient_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_alert/external/datasources/patient_alert_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_alert/presenter/controller/patient_alert_controller.dart';
import 'package:medicinadireta/modules/patient_information/presenter/controller/find_data_patient_controller.dart';
import 'package:medicinadireta/modules/patient_information/presenter/controller/patient_datails_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/external/datasource/attachements_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/controller/attachments_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/controller/camera_gallery_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/external/datasource/communication_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/presenter/controller/communication_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/external/datasource/evolution_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/presenter/controller/evolution_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/external/datasource/general_data_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/presenter/controller/general_data_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/external/datasource/medicines_in_use_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/presenter/controller/medicine_in_use_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/memed/presenter/controllers/memed_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/external/datasource/relationship_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/presenter/controller/relationship_controller.dart';

class PatientDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(CameraGalleryController());
    Get.put(SharedPreferencesHelper());
    Get.put(CheckConnectingNetwork());
    Get.put(PatientDetailsController());
    Get.put(AppDeviceInfoController());

    Get.put(VerificationAccessMenuUser(
      sharedPreferences: Get.find<SharedPreferencesHelper>(),
      deviceInfo: Get.find<AppDeviceInfoController>(),
    ));

    Get.put(AttachmentsDatasourceImpl(Get.find<Network>()));
    Get.put(GeneralDataDatasourceImpl(Get.find<Network>()));
    Get.put(ModelToMailDatasourceImpl(Get.find<Network>()));
    Get.put(EvolutionDatasourceImpl(Get.find<Network>()));
    Get.put(CommunicationDatasourceImpl(Get.find<Network>()));
    Get.put(PatientDatasourceImpl(Get.find<Network>()));
    Get.put(RelationshipDatasourceImpl(Get.find<Network>()));
    Get.put(PatientAlertDatasourceImpl(Get.find<Network>()));
    Get.put(
      AttachmentsController(
        request: Get.find<AttachmentsDatasourceImpl>(),
        cameraGallery: Get.find<CameraGalleryController>(),
      ),
    );
    Get.put(
      CommunicationController(
        request: Get.find<CommunicationDatasourceImpl>(),
        requestPatient: Get.find<PatientDatasourceImpl>(),
      ),
    );
    Get.put(
      EvolutionController(
        connecting: Get.find<CheckConnectingNetwork>(),
        request: Get.find<EvolutionDatasourceImpl>(),
        shared: Get.find<SharedPreferencesHelper>(),
      ),
    );
    Get.put(
      GeneralDataController(
        request: Get.find<GeneralDataDatasourceImpl>(),
        newPhone: Get.find<ModelToMailDatasourceImpl>(),
        shared: Get.find<SharedPreferencesHelper>(),
        cameraGallery: Get.find<CameraGalleryController>(),
      ),
    );
    Get.put(MedicinesInUseDatasourceImpl(Get.find<Network>()));
    Get.put(
      MedicineInUseController(
        Get.find<MedicinesInUseDatasourceImpl>(),
      ),
    );
    Get.put(
      RelationshipController(
        requestServer: Get.find<RelationshipDatasourceImpl>(),
        sharedPreferences: Get.find<SharedPreferencesHelper>(),
        requestPatient: Get.find<PatientDatasourceImpl>(),
      ),
    );
    Get.put(
      FindDataPatientController(
        Get.find<PatientDatasourceImpl>(),
        Get.find<CheckConnectingNetwork>(),
        Get.find<CameraGalleryController>(),
        Get.find<GeneralDataDatasourceImpl>(),
      ),
    );

    Get.put(
      MemedController(Get.find<SharedPreferencesHelper>()),
    );
    
    Get.put(
      PatientAlertController(
        Get.find<PatientAlertDatasourceImpl>(),
        Get.find<CheckConnectingNetwork>(),
      ),
    );
  }
}
