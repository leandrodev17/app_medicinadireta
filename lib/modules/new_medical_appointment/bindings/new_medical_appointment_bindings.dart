import 'package:medicinadireta/core/binding_from_initial/commons_controller.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/modules/contact/external/datasource/contact_datasource_impl.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/controllers/doctor_commitment_controller.dart';
import 'package:medicinadireta/modules/modules_helpers/external/datasource/model_to_mail_datasource_impl.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/controller/model_to_mail_controller.dart';
import 'package:medicinadireta/modules/new_medical_appointment/external/datasource/new_medical_appointment_datasource_impl.dart';
import 'package:medicinadireta/modules/new_medical_appointment/presenter/controller/new_medical_appointment_controller.dart';
import 'package:medicinadireta/modules/new_patient/external/datasource/new_patient_datasource_impl.dart';
import 'package:medicinadireta/modules/new_patient/presenter/controller/new_patient_controller.dart';
import 'package:medicinadireta/modules/patient/external/datasource/patient_datasource_impl.dart';
import 'package:medicinadireta/modules/patient/presenter/controller/patient_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class NewMedicalAppointmentBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(CommonsController());
    Get.put(ContactDatasourceImpl(Get.find<Network>()));
    Get.put(ContactDatasourceImpl(Get.find<Network>()));
    Get.put(NewPatientDatasourceImpl(Get.find<Network>()));
    Get.put(PatientDatasourceImpl(Get.find<Network>()));
    Get.put(NewMedicalAppointmentDatasourceImpl(Get.find<Network>()));
    Get.put(ModelToMailDatasourceImpl(Get.find<Network>()));
    Get.put(ModelToMailController(Get.find<ModelToMailDatasourceImpl>()));
    Get.put(NewPatientController(
      newPatient: Get.find<NewPatientDatasourceImpl>(),
    ));

    Get.put(
      PatientController(
        request: Get.find<PatientDatasourceImpl>(),
      ),
    );

    Get.put(NewMedicalAppointmentController(
      requestContacts: Get.find<ContactDatasourceImpl>(),
      newPatient: Get.find<NewPatientDatasourceImpl>(),
      controllerNewPatient: Get.find<NewPatientController>(),
      controllerListPatient: Get.find<PatientController>(),
      commitmentController: Get.find<DoctorCommitmentController>(),
      modelToMail: Get.find<ModelToMailDatasourceImpl>(),
      request: Get.find<NewMedicalAppointmentDatasourceImpl>(),
      newPhonePatient: Get.find<ModelToMailController>(),
    ));
  }
}
