import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient/external/datasource/patient_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/entities/network/request_relationship.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/external/datasource/relationship_datasource_impl.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RelationshipController extends GetxController {
  final RelationshipDatasourceImpl requestServer;
  final SharedPreferencesHelper sharedPreferences;
  final PatientDatasourceImpl requestPatient;
  RelationshipController({required this.requestServer, required this.sharedPreferences, required this.requestPatient});

  final TextEditingController messageController = TextEditingController();
  final FocusNode messageFocusNode = FocusNode();

  final RxBool loading = RxBool(false);
  late final RxString message = RxString('null');

  void onChangeMessage(String? data) => message.value = data!;

  bool get isMessage => (message.value != '' && message.value.isNotEmpty);

  String? get messageError {
    if (message.value != '' || isMessage) return null;
    return 'requiredField'.tr;
  }

  getPacienteId(int patientId) async {
    await _findPacienteId(patientId);
  }

  _findPacienteId(int patientId) async {
    try {
      var _params = QueryParameters(select: "id,prontuario,nome,idade,email,dataNascimento,observacoes");
      final _response = await requestPatient.findPatientIdDatasource(_params, patientId);
      if (_response.model != null) {
        var _observacoes = _response.model?.first.observacoes ?? '';
        messageController.text = _observacoes;
        message.value = _observacoes;
      }
    } catch (e) {
      AppLog.d('Não foi possível buscar o paciente $e', name: '_findPacienteId');
    }
  }

  save(ParamsToNavigationPage params) async {
    try {
      loading.value = true;
      await 1.delay();
      final req = RequestRelationship(relacionamento: message.toString());
      final response = await requestServer.saveRelationshipDatasource(req, params.pacienteId!);
      loading.value = false;
      if (response.statusCode != 200) {
        AppAlert.alertWarning(title: 'Não foi possível salvar', body: 'Não foi possível salvar');
      }
      if (response.statusCode == 200) {
        AppAlert.alertSuccess(title: 'Salvo com sucesso', body: 'Salvo com sucesso');
      }
      await 0.5.delay();
      // Get.back(closeOverlays: true);
      // Get.back();
      await Get.toNamed(Routes.PATIENT_DETAILS, arguments: params);
    } catch (e) {
      loading.value = false;
      AppLog.d('Não foi possível salvar $e', name: 'save relacionamento');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
