import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient/external/datasource/patient_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/request_communication.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:medicinadireta/modules/patient_information/submodules/communication/external/datasource/communication_datasource_impl.dart';

class CommunicationController extends GetxController {
  final CommunicationDatasourceImpl request;
  final PatientDatasourceImpl requestPatient;
  CommunicationController({required this.request, required this.requestPatient});

  final RxBool loadingSave = RxBool(false);
  final RxInt optionComunication = RxInt(0);

  final assuntoController = TextEditingController();
  final mensagemController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final assuntoFocusNode = FocusNode();
  final mensagemFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  final RxString assuntoCommunication = RxString('null');
  void setAssuntoCommunication(String? value) => assuntoCommunication.value = value!;
  bool get validErrorAssuntoEmpty => assuntoCommunication.value != '' && assuntoCommunication.value.isNotEmpty;
  String? get assuntoError {
    if (assuntoCommunication.value != '' || validErrorAssuntoEmpty) return null;
    return 'requiredField'.tr;
  }

  void changeOptionComunication(int? op) {
    if (op != null) {
      optionComunication.value = op;
    }
  }

  final Rx<DateTime> schedulingDatetime = Rx<DateTime>(DateTime.now());
  void setSchedulingDatetime(DateTime? value) {
    if (value != null) {
      schedulingDatetime.value = value;
    }
  }

  int get limitScheduling {
    final daysDiff = DateTime.now().difference(schedulingDatetime.value).inDays;
    return (daysDiff / 365).floor();
  }

  bool get validSchedulingError => limitScheduling < 1;
  String? get schedulingError {
    if (validSchedulingError) return null;
    return 'Data informada não é válida'.tr;
  }

  final RxString emailCommunication = RxString('');
  void setEmailCommunication(String? value) => emailCommunication.value = value!;
  bool get validErrorMailEmpty => emailCommunication.value != '' && emailCommunication.value.isEmail;
  String? get mailError {
    if (emailCommunication.value != '' && validErrorMailEmpty) {
      return null;
    } else if (emailCommunication.value.isEmpty) {
      return 'requiredField'.tr;
    } else if (emailCommunication.value != '' && !emailCommunication.value.isEmail) {
      return 'mail_invalid'.tr;
    }
    return null;
  }
  //0 = validSchedulingError && validErrorMailEmpty

  final RxString messageCommunication = RxString('null');
  void setMessageCommunication(String? value) => messageCommunication.value = value!;
  bool get validErrorMessageEmpty => messageCommunication.value != '' && messageCommunication.value.isNotEmpty;
  String? get messageError {
    if (messageCommunication.value != '' || validErrorMessageEmpty) return null;
    return 'requiredField'.tr;
  }

  final RxString phoneCommunication = RxString('');
  void setPhoneCommunication(String? value) => phoneCommunication.value = value!;
  bool get validPhoneComunication => phoneCommunication.value != '' && phoneCommunication.value.isNotEmpty;
  String? get phoneCommunicationError {
    if (phoneCommunication.value != '' || validPhoneComunication) return null;
    return 'requiredField'.tr;
  }

  bool get isPressedSave => optionComunication.value == 0 ? (validSchedulingError && validErrorMailEmpty) : (validSchedulingError && validPhoneComunication);

  saveDataCommunication(ParamsToNavigationPage params) async {
    if (optionComunication.value == 0) {
      await saveDataCommunicationEmail(params);
    } else {
      await saveDataCommunicationSMS(params);
    }
  }

  saveDataCommunicationEmail(ParamsToNavigationPage params) async {
    try {
      loadingSave.value = true;
      var userId = await SharedPreferencesHelper().userId;
      var req = RequestCommunication(
        assunto: assuntoCommunication.value,
        corPara: params.pacienteId,
        mensagem: messageCommunication.value,
        dataEnvio: FormatsDatetime.apiDateFormat.format(schedulingDatetime.value),
        emailPaciente: emailCommunication.value,
        horaEnvio: FormatsDatetime.apiTimeFormat.format(schedulingDatetime.value),
        remetenteId: userId,
      );

      final response = await request.saveCommunicationDatasource(req);

      loadingSave.value = false;
      if (response.statusCode != 201) {
        await AppAlert.alertError(title: "Oops!", body: "Não foi possível enviar os dados", seconds: 5);
      }

      await AppAlert.alertSuccess(title: "Sucesso!", body: "Solicitação com sucesso!", seconds: 5);
      await 0.5.delay();
      await Get.toNamed(Routes.PATIENT_DETAILS, arguments: params);
    } catch (e) {
      AppLog.d('Não foi possível salvar a comunicacao $e', name: 'saveDataCommunicationEmail');
      loadingSave.value = false;
    }
  }

  saveDataCommunicationSMS(ParamsToNavigationPage params) async {
    try {
      loadingSave.value = true;
      var req = RequestCommunication(
        assunto: assuntoCommunication.value,
        smsPara: params.pacienteId,
        dddCelular: phoneCommunication.value.replaceAll(" ", "").replaceAll("(", "").replaceAll(")", ""),
        mensagem: messageCommunication.value,
        dataEnvio: FormatsDatetime.apiDateFormat.format(schedulingDatetime.value),
        horaEnvio: FormatsDatetime.apiTimeFormat.format(schedulingDatetime.value),
      );

      final response = await request.sendSMSCommunicationDatasource(req);
      loadingSave.value = false;
      if (response.statusCode != 200) {
        await AppAlert.alertError(title: "Oops!", body: "Não foi possível enviar os dados", seconds: 5);
      }

      await AppAlert.alertSuccess(title: "Sucesso!", body: "Solicitação com sucesso!", seconds: 5);
      await 0.5.delay();
      await Get.toNamed(Routes.PATIENT_DETAILS, arguments: params);
    } catch (e) {
      AppLog.d('Não foi possível salvar a comunicacao $e', name: 'saveDataCommunicationSMS');
      loadingSave.value = false;
    }
  }

  //TODO NAO FOI PRECISO O USO, PORÉM DEIXEI AQUI. REMOVER DEPOIS DA PRIMEIRA FASE
  getPacienteId(int patientId) async => await _findPacienteId(patientId);

  _findPacienteId(int patientId) async {
    try {
      var _params = QueryParameters(select: "id,prontuario,nome,idade,email,dataNascimento,observacoes");
      final _response = await requestPatient.findPatientIdDatasource(_params, patientId);
      if (_response.model != null) {
        var _model = _response.model?.first ?? null;
        var _email = _model != null ? _model.email.toString() : '';
        emailController.text = _email;
        emailCommunication.value = _email;
      }
    } catch (e) {
      AppLog.d('Não foi possível buscar o paciente comunicaçao $e', name: '_findPacienteId');
    }
  }

  @override
  void dispose() {
    assuntoController.dispose();
    mensagemController.dispose();
    emailController.dispose();
    assuntoFocusNode.dispose();
    mensagemFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    ParamsToNavigationPage _params = Get.arguments;
    emailController.text = _params.email ?? '';
    emailCommunication.value = _params.email ?? '';

    var _phone = _params.telefone?.replaceAll("+55", "");
    phoneController.text = _phone ?? '';
    phoneCommunication.value = _phone ?? '';
  }
}
