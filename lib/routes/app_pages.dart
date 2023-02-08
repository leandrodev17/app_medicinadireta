import 'package:get/get.dart';

import 'package:medicinadireta/core/page_not_access/presenter/page_not_access_screen.dart';
import 'package:medicinadireta/modules/authentication/bingings/authetication_bindings.dart';
import 'package:medicinadireta/modules/authentication/presenter/authetication_screen.dart';
import 'package:medicinadireta/modules/change_password/bindings/change_password_bindings.dart';
import 'package:medicinadireta/modules/change_password/presenter/pages/change_password_phone.dart';
import 'package:medicinadireta/modules/doctor_schedule/bingings/doctor_schedule_bindings.dart';
import 'package:medicinadireta/modules/doctor_schedule/presenter/doctor_schedule_screen.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/bingings/doctor_schedule_and_patient_bindings.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/presenter/doctor_schedule_patient_screen.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/bingings/doctor_commitment_bindings.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/doctor_commitment_screen.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/list_appointment_screen.dart';
import 'package:medicinadireta/modules/financial/bindings/financial_bindings.dart';
import 'package:medicinadireta/modules/financial/presenter/financial_screen.dart';
import 'package:medicinadireta/modules/force_update/bindings/update_version_bindings.dart';
import 'package:medicinadireta/modules/force_update/presenter/update_version_screen.dart';
import 'package:medicinadireta/modules/infor_med/bindings/Infor_med_bindings.dart';
import 'package:medicinadireta/modules/infor_med/presenter/infor_med_screen.dart';
import 'package:medicinadireta/modules/menu/bindings/menu_bindings.dart';
import 'package:medicinadireta/modules/menu/presenter/menu_screen.dart';
import 'package:medicinadireta/modules/modules_helpers/bindings/model_to_mail_bindings.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/medical_register_screen.dart';
import 'package:medicinadireta/modules/new_medical_appointment/bindings/new_medical_appointment_bindings.dart';
import 'package:medicinadireta/modules/new_medical_appointment/presenter/new_medical_appointment_screen.dart';
import 'package:medicinadireta/modules/new_patient/bindings/new_patient_bindings.dart';
import 'package:medicinadireta/modules/new_patient/presenter/new_patient_screen.dart';
import 'package:medicinadireta/modules/panel_control/bindings/panel_control_bindings.dart';
import 'package:medicinadireta/modules/panel_control/presenter/panel_control_screen.dart';
import 'package:medicinadireta/modules/patient/bindings/patient_bindings.dart';
import 'package:medicinadireta/modules/patient/presenter/patient_screen.dart';
import 'package:medicinadireta/modules/patient_information/bindings/patient_details_bindings.dart';
import 'package:medicinadireta/modules/patient_information/patient_details_screen.dart';
import 'package:medicinadireta/modules/patient_information/submodules/alerts/bindings/alert_bindings.dart';
import 'package:medicinadireta/modules/patient_information/submodules/alerts/presenter/alert_screen.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/bindings/anamnese_bindings.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/presenter/anamnese_screen.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anthropometry/bindings/anthropometry_bindings.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anthropometry/presenter/anthropometry_screen.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/attachments_screen.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/bindings/attachments_bindings.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/bindings/communication_bindings.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/communication_screen.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/bindings/evolution_bindings.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/evolution_screen.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/bindings/exams_bindings.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/presenter/exams_screen.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/bindings/form_plan_bindings.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/presenter/form_plan_screen.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/bindings/general_data_bindings.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/general_data_screen.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/bindings/medicine_detail_bindings.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/bindings/medicine_in_use_bindings.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/medicine_detail_screen.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/medicine_in_use_screen.dart';
import 'package:medicinadireta/modules/patient_information/submodules/memed/presenter/pages/embedded_memed.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/bindings/prescription_bindings.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/presenter/prescription_screen.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/bindings/relationship_bindings.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/relationship_screen.dart';
import 'package:medicinadireta/modules/reschedule_committed/bindings/reschudule_committed.dart';
import 'package:medicinadireta/modules/reschedule_committed/presenter/pages/reschedule/view_reschedule.dart';
import 'package:medicinadireta/modules/reschedule_committed/presenter/pages/reschedule_snap/view_reschedule_snap.dart';
import 'package:medicinadireta/modules/splash/bindings/splash_bindings.dart';
import 'package:medicinadireta/modules/splash/presenter/splash_screen.dart';
import 'package:medicinadireta/modules/support/bindings/support_bindings.dart';
import 'package:medicinadireta/modules/support/presenter/pages/support_phone.dart';

import '../modules/patient_information/submodules/pressure/bindings/pressure_bindings.dart';
import '../modules/patient_information/submodules/pressure/presenter/pressure_screen.dart';
import '/core/page_not_access/presenter/page_not_access_screen.dart';
import '/modules/authentication/bingings/authetication_bindings.dart';
import '/modules/authentication/presenter/authetication_screen.dart';
import '/modules/change_password/bindings/change_password_bindings.dart';
import '/modules/change_password/presenter/pages/change_password_phone.dart';
import '/modules/doctor_schedule/bingings/doctor_schedule_bindings.dart';
import '/modules/doctor_schedule/presenter/doctor_schedule_screen.dart';
import '/modules/doctor_schedule_and_patient/bingings/doctor_schedule_and_patient_bindings.dart';
import '/modules/doctor_schedule_and_patient/presenter/doctor_schedule_patient_screen.dart';
import '/modules/doctor_schedule_list_commitment/bingings/doctor_commitment_bindings.dart';
import '/modules/doctor_schedule_list_commitment/presenter/doctor_commitment_screen.dart';
import '/modules/doctor_schedule_list_commitment/presenter/list_appointment_screen.dart';
import '/modules/financial/bindings/financial_bindings.dart';
import '/modules/financial/presenter/financial_screen.dart';
import '/modules/force_update/bindings/update_version_bindings.dart';
import '/modules/force_update/presenter/update_version_screen.dart';
import '/modules/infor_med/bindings/Infor_med_bindings.dart';
import '/modules/infor_med/presenter/infor_med_screen.dart';
import '/modules/menu/bindings/menu_bindings.dart';
import '/modules/menu/presenter/menu_screen.dart';
import '/modules/new_medical_appointment/bindings/new_medical_appointment_bindings.dart';
import '/modules/new_medical_appointment/presenter/new_medical_appointment_screen.dart';
import '/modules/new_patient/bindings/new_patient_bindings.dart';
import '/modules/new_patient/presenter/new_patient_screen.dart';
import '/modules/panel_control/bindings/panel_control_bindings.dart';
import '/modules/panel_control/presenter/panel_control_screen.dart';
import '/modules/patient/bindings/patient_bindings.dart';
import '/modules/patient/presenter/patient_screen.dart';
import '/modules/patient_information/bindings/patient_details_bindings.dart';
import '/modules/patient_information/patient_details_screen.dart';
import '/modules/patient_information/submodules/alerts/bindings/alert_bindings.dart';
import '/modules/patient_information/submodules/alerts/presenter/alert_screen.dart';
import '/modules/patient_information/submodules/allergy/bindings/allergy_bindings.dart';
import '/modules/patient_information/submodules/allergy/presenter/allergy_screen.dart';
import '/modules/patient_information/submodules/anamnese/bindings/anamnese_bindings.dart';
import '/modules/patient_information/submodules/anamnese/presenter/anamnese_screen.dart';
import '/modules/patient_information/submodules/attachments/attachments_screen.dart';
import '/modules/patient_information/submodules/attachments/bindings/attachments_bindings.dart';
import '/modules/patient_information/submodules/communication/bindings/communication_bindings.dart';
import '/modules/patient_information/submodules/communication/communication_screen.dart';
import '/modules/patient_information/submodules/evolution/bindings/evolution_bindings.dart';
import '/modules/patient_information/submodules/evolution/evolution_screen.dart';
import '/modules/patient_information/submodules/general_data/bindings/general_data_bindings.dart';
import '/modules/patient_information/submodules/general_data/general_data_screen.dart';
import '/modules/patient_information/submodules/medicines_in_use/bindings/medicine_detail_bindings.dart';
import '/modules/patient_information/submodules/medicines_in_use/bindings/medicine_in_use_bindings.dart';
import '/modules/patient_information/submodules/medicines_in_use/medicine_detail_screen.dart';
import '/modules/patient_information/submodules/medicines_in_use/medicine_in_use_screen.dart';
import '/modules/patient_information/submodules/relationship/bindings/relationship_bindings.dart';
import '/modules/patient_information/submodules/relationship/relationship_screen.dart';
import '/modules/reschedule_committed/bindings/reschudule_committed.dart';
import '/modules/reschedule_committed/presenter/pages/reschedule/view_reschedule.dart';
import '/modules/reschedule_committed/presenter/pages/reschedule_snap/view_reschedule_snap.dart';
import '/modules/splash/bindings/splash_bindings.dart';
import '/modules/splash/presenter/splash_screen.dart';
import '/modules/support/bindings/support_bindings.dart';
import '/modules/support/presenter/pages/support_phone.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => SplashScreen(), binding: SplashBindings()),
    GetPage(name: Routes.AUTH, page: () => AutheticationScreen(), binding: AutheticationBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.DOCTOR_ACHEDULE, page: () => DoctorScheduleScreen(), binding: DoctorScheduleBindings(), transition: Transition.fadeIn),

    //LISTA AGENDAMENTOS DOS MÉDICOS E OS PACIENTES AGENDADO PARA CADA HORÁRIO
    GetPage(name: Routes.DOCTOR_ACHEDULE_PATIENT, page: () => DoctorSchedulePatientScreen(), binding: DoctorScheduleAndPatientBindings(), transition: Transition.fadeIn),

    // Usam a mesta rota no server, a diferença é os parametros.
    GetPage(name: Routes.DOCTOR_COMMITMENT, page: () => DoctorCommitmentScreen(), binding: DoctorCommitmentBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.LIST_APPOINTMENT, page: () => ListAppointmentScreen(), transition: Transition.fadeIn),

    GetPage(name: Routes.FINANCIAL, page: () => FinancialScreen(), binding: FinancialBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.LIST_PATIENT, page: () => PatientScreen(), binding: PatientBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.PANEL_CONTROL, page: () => PanelControlScreen(), binding: PanelControlBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.CHANGE_PASSWORD, page: () => ChangePasswordPhone(), binding: ChangePasswordBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.SUPPORT, page: () => SupportPhone(), binding: SupportBindings(), transition: Transition.fadeIn),

    GetPage(name: Routes.NEW_MEDICAL_APPOINTMENT, page: () => NewMedicalAppointmentScreen(), binding: NewMedicalAppointmentBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.NEW_PATIENT, page: () => NewPatientScreen(), binding: NewPatientBindings(), transition: Transition.fadeIn),

    //FLUXO DE DETALHES DO PACIENTE
    GetPage(name: Routes.PATIENT_DETAILS, page: () => PatientDetailsScreen(), binding: PatientDetailsBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.COMMUNICATION, page: () => CommunicationScreen(), binding: CommunicationBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.EVOLUTION, page: () => EvolutionScreen(), binding: EvolutionBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.RELATIONSHIP, page: () => RelationshipScreen(), binding: RelationshipBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.GENERAL_DATA, page: () => GeneralDataScreen(), binding: GeneralDataBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.ATTACHMENTS, page: () => AttachmentScreen(), binding: AttachmentsBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.MEDICINES_IN_USE, page: () => MedicinesInUseScreen(), binding: MedicineInUseBindings(), transition: Transition.fadeIn),
    GetPage(name: Routes.MEDICINES_DETAIL, page: () => MedicineDetailScreen(), binding: MedicineDetailBindings(), transition: Transition.fadeIn),
    // FIM DO FLUXO

    /// REMARCAR CONSULTA, REMARCAR/ENCAIXE E ENCAIXE
    GetPage(name: Routes.RESCHEDULE, page: () => ViewReschedule(), binding: ReschuduleCommitted(), transition: Transition.fadeIn),
    GetPage(name: Routes.RESCHEDULE_SNAP, page: () => ViewRescheduleSnap(), binding: ReschuduleCommitted(), transition: Transition.fadeIn),

    //MENU
    GetPage(name: Routes.MENU, page: () => MenuScreen(), binding: MenuBindings(), transition: Transition.fadeIn),

    ///Infor Med
    GetPage(name: Routes.INFOR_MED, page: () => InforMedScreen(), binding: InforMedBindings(), transition: Transition.fadeIn),

    ///Infor Med
    GetPage(name: Routes.PAGE_UPDATE_VERSIO_APP, page: () => UpdateVersionScreen(), binding: UpdateVersionBindings(), transition: Transition.fadeIn),

    ///SEM ACESSO AO CONTEÚDO
    GetPage(name: Routes.NOT_ACCESS, page: () => PageNotAccessScreen(), transition: Transition.fadeIn),

    ///ANAMNESE
    GetPage(name: Routes.ANAMNESE, page: () => const AnamneseScreen(), binding: AnamneseBindings(), transition: Transition.fadeIn),

    ///Alertas do paciente
    GetPage(name: Routes.ALERTAS, page: () => const AlertScreen(), binding: AlertBindings(), transition: Transition.fadeIn),

    ///Alergias
    GetPage(name: Routes.ALLERGYS, page: () => const AllergyScreen(), binding: AllergyBindings(), transition: Transition.fadeIn),

    ///Cadastro de medicamentos
    GetPage(name: Routes.drugRegistration, page: () => const MedicalRegisterScreen(), binding: ModelToMailBindings(), transition: Transition.fadeIn),

    ///SOAP=>Plano=>Receita
    GetPage(name: Routes.prescription, page: () => const PrescriptionScreen(), binding: PrescriptionBindings(), transition: Transition.fadeIn),

    ///SOAP=>Plano=>Exames
    GetPage(name: Routes.exams, page: () => const ExamsScreen(), binding: ExamsBindings(), transition: Transition.fadeIn),

    ///memed
    GetPage(name: Routes.MEMED, page: () => EmbeddedMemed(), transition: Transition.fadeIn),

    /// SOAP=>Plano=>formulário
    GetPage(name: Routes.formPlan, page: () => const FormPlanScreen(), binding: FormPlanBindings(), transition: Transition.fadeIn),

    ///Anthropometry
    GetPage(name: Routes.anthropometry, page: () => const AnthropometryScreen(), binding: AnthropometryBindings(), transition: Transition.fadeIn),

    ///Pressure
    GetPage(name: Routes.pressure, page: () => const PressureScreen(), binding: PressureBindings(), transition: Transition.fadeIn),
  ];
}
