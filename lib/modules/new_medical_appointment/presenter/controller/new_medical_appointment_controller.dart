import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/models/patient/patient_model_ext.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/contact/external/datasource/contact_datasource_impl.dart';
import 'package:medicinadireta/modules/contact/infra/models/contact_ext.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/doctor_commitment_ext.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/controllers/doctor_commitment_controller.dart';
import 'package:medicinadireta/modules/modules_helpers/external/datasource/model_to_mail_datasource_impl.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/model_to_mail_ext.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/model_to_sms_ext.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/controller/model_to_mail_controller.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_notification.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_schedule.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_schedule_snap.dart';
import 'package:medicinadireta/modules/new_medical_appointment/external/datasource/new_medical_appointment_datasource_impl.dart';
import 'package:medicinadireta/modules/new_patient/domain/entities/network/request_new_patient.dart';
import 'package:medicinadireta/modules/new_patient/external/datasource/new_patient_datasource_impl.dart';
import 'package:medicinadireta/modules/new_patient/presenter/controller/new_patient_controller.dart';
import 'package:medicinadireta/modules/patient/presenter/controller/patient_controller.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/model_from_request_to_snap.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewMedicalAppointmentController extends GetxController {
  final ContactDatasourceImpl requestContacts;
  final NewPatientDatasourceImpl newPatient;
  final NewPatientController controllerNewPatient;
  final PatientController controllerListPatient;
  final NewMedicalAppointmentDatasourceImpl request;
  final ModelToMailDatasourceImpl modelToMail;
  final DoctorCommitmentController commitmentController;
  final ModelToMailController newPhonePatient;
  // PatientDatasourceImpl

  NewMedicalAppointmentController({
    required this.requestContacts,
    required this.newPatient,
    required this.controllerNewPatient,
    required this.controllerListPatient,
    required this.request,
    required this.modelToMail,
    required this.commitmentController,
    required this.newPhonePatient,
  });

  final RxList<String> typeRegisted = <String>['new_patient'.tr, 'old_patient'.tr, 'commitment'.tr].obs;
  final RxInt indexTypeRegisted = RxInt(0);
  final RxList<ContactExt> listContacts = RxList<ContactExt>();
  final RxList<ModelToMailExt> listModelToMail = RxList<ModelToMailExt>();
  final RxList<ModelToSmsExt> listModelToSms = RxList<ModelToSmsExt>();
  final RxInt contactId = RxInt(0);
  final RxInt patientId = RxInt(0);

  final dateTimeController = TextEditingController();
  final titleController = TextEditingController();
  final sendMailController = TextEditingController();
  final phoneSMSController = TextEditingController();
  final dateTimeFocusNode = FocusNode();
  final phoneSMSFocusNode = FocusNode();
  final titleFocusNode = FocusNode();
  final sendMailFocusNode = FocusNode();

  final RxBool loadingSave = RxBool(false);

  @override
  void dispose() {
    dateTimeController.dispose();
    titleController.dispose();
    sendMailController.dispose();
    phoneSMSController.dispose();
    phoneSMSFocusNode.dispose();
    dateTimeFocusNode.dispose();
    titleFocusNode.dispose();
    sendMailFocusNode.dispose();
    super.dispose();
  }

  RxInt valueKeyNewPacient = RxInt(DateTime.now().millisecondsSinceEpoch);
  RxInt valueKeyFindPacient = RxInt(DateTime.now().millisecondsSinceEpoch);
  ModelFromRequestToSnap requestToSnap = ModelFromRequestToSnap();

  ///Encaixe
  Rx<DateTime> datetimeCurrent = Rx<DateTime>(DateTime.now());

  // somente para gravar hora e data para enviar no disparo da notificacao por email ou sms
  final RxInt _appointmentId = RxInt(0);

  // New paciente
  // final labelNewPatient = 'new_patient'.tr.obs;
  TextEditingController textFieldNewPatient = TextEditingController();

  // pesquisa por um pacient
  // final labelNamePatientFind = 'old_patient'.tr.obs;
  TextEditingController textFieldNamePatientFind = TextEditingController();

  // Lista de contatos
  // final labelContacts = 'commitment'.tr.obs;

  //Modelo para email
  final labelModelToMail = 'select_model'.tr.obs;

  //MOdelo para sms
  final labelModelToSms = 'select_model'.tr.obs;

  // Somente para identificar se existe valor no Novo Paciente ou Lista de Paciente ou Compromisso
  final isValidValue = 0.obs;

  // Identificação de envio de SMS e EMAIL
  // Se o valor for TRUE envia as funções de Envio de notificação
  final typeSendSms = false.obs;
  final typeSendMail = false.obs;

  RxBool _isTypeCommitment = RxBool(false);

  /// Data e Horário do agendamento para encaixe
  Rx<DateTime?>? dateTimeRescheduleSnap;

  ///Item do modelo de e-mail a ser informado no envio
  // RxString? itemModelEmail;

  // bool get validNewPatient => labelNewPatient.value != 'new_patient'.tr;
  // bool get validFindPatient => labelNamePatientFind.value != 'old_patient'.tr;

  /// [validSelectContact] não precisa verificar, pois não é preciso selecionar um contato
  // bool get validSelectContact => labelContacts.value == 'commitment'.tr || labelContacts.value != 'commitment'.tr;

  /// ATENCÃO: [selectedOptions] Seguinifica que o usuário escolheu alguma opçao (Novo paciente, paciente cadastrado ou um Compromisso)
  /// Se faz obrigatório a escolha de algum item para um agendamento ou um encaixe.
  bool get selectedOptions => isValidValue.value != 0;

  showDatePickerData() async {
    DateTime dateTime = DateTime.now();

    DateTime? date = await showDatePicker(
      context: Get.context!,
      locale: const Locale("pt", "BR"),
      firstDate: DateTime.now().subtract(const Duration(days: 31)),
      lastDate: DateTime(DateTime.now().year + 1, 12, 30),
      initialDate: datetimeCurrent.value,
    );
    if (date != null) {
      final time = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );
      dateTime = DateTimeField.combine(date, time);
    }
    datetimeCurrent.value = dateTime;
    var time = FormatsDatetime.formatDate(dateTime, FormatsDatetime.apiTimeFormat);
    var dateData = dateTime.add(const Duration(hours: -3));
    requestToSnap = requestToSnap.copyWith(
      dataInicio: dateData.toUtc().toIso8601String(),
      dataFim: dateData.toUtc().toIso8601String(),
      horaInicio: time,
      horaFim: time,
    );
  }

  findContats() async {
    try {
      listContacts.clear();
      final response = await requestContacts.findContactDatasource();
      if (response.model!.isNotEmpty) listContacts.addAll(response.model!);
    } catch (e) {
      AppLog.d('Não foi possível socilitar a lista de contatos $e', name: 'Lista de contatos');
    }
  }

  findModelToMail() async {
    try {
      listModelToMail.clear();
      final response = await modelToMail.findModelToMailDatasource();
      if (response.model!.isNotEmpty) {
        listModelToMail.addAll(response.model!);
      }
    } catch (e) {
      AppLog.d('Não foi possível socilitar a lista de modelo de e-mail $e', name: 'Lista model de e-mail');
    }
  }

  findModelToSms() async {
    try {
      listModelToSms.clear();
      final response = await modelToMail.findModelToSmsDatasource();
      if (response.model!.isNotEmpty) listModelToSms.addAll(response.model!);
    } catch (e) {
      AppLog.d('Não foi possível socilitar a lista de modelo de e-mail $e', name: 'Lista model de sms');
    }
  }

  void onChangeTypeMail(bool? data) {
    if (data != null) {
      typeSendMail.value = !typeSendMail.value;
      // _emptyCardsMailSMS();
    }
  }

  void onChangeTypeSms(bool? data) {
    if (data != null) {
      typeSendSms.value = !typeSendSms.value;
      // _emptyCardsMailSMS();
    }
  }

  void onChangeContacts(dynamic data) {
    if (data != null) {
      contactId.value = data['contatoId'];
      isValidValue.value = data['contatoId'] ?? 0;
    }
  }

  void onChangeTypeRegisted(int? index) {
    if (index != null) {
      textFieldNamePatientFind.clear();
      textFieldNewPatient.clear();
      typeSendSms.value = false;
      typeSendMail.value = false;
      // zerar o tipo de registro para false
      _isTypeCommitment.value = false;

      indexTypeRegisted.value = index;
      _emptyChangeTypeRegisted();
      if (index == 0) valueKeyNewPacient.value = DateTime.now().millisecondsSinceEpoch;
      if (index == 1) valueKeyFindPacient.value = DateTime.now().millisecondsSinceEpoch;
      if (index == 2) {
        _isTypeCommitment.value = true;
        isValidValue.value = 1; // somente para passar na validacao, pois o tipo COMPROMISSO pode ser enviado com NULL ou seja sem escolher um responsável
      }
    }
  }

  emptyDataSendToServer() {
    titleController.clear();
    isValidValue.value = 0;
    sendMailController.clear();
    phoneSMSController.clear();
    typeSendMail.value = false;
    typeSendSms.value = false;

    _isTypeCommitment.value = false; // zera o tipo de cadastro compromisso

    // seta para novo paciente
    indexTypeRegisted.value = 1;
    valueKeyFindPacient.value = DateTime.now().millisecondsSinceEpoch;

    // mailScheduling.value = _response.model?.email ?? '';
    contactId.value = 0;

    //  Após concluir o envio deixa somente o titulo obrigatório.
    // seta o valor 0 para obrigar o usuário escolher outra opção ou cadastrar um paciente, assim no final do cadastro seta para um valor diferente de 0 e permite o cadastro
    isValidValue.value = 0;

    /// Para evitar que marque algo para outro paciente
    patientId.value = 0;

    _emptyChangeTypeRegisted();
  }

  // Limpar os dados ao trocar de opção, assim evita enviar para o user errado
  _emptyChangeTypeRegisted() {
    // Limpa informações digitadas no bloco email se houver uma troca de tipo de registro
    sendMailController.clear();
    labelModelToMail.value = 'select_model'.tr;

    //  Limpa informações digitadas no bloco SMS se houver uma troca de tipo de registro
    labelModelToSms.value = 'select_model'.tr;
    phoneSMSController.clear();
  }

  RxBool loadingSaveNewPatient = RxBool(false);
  Rx<DateTime?>? birthday;

  //Novo paciente
  saveNewPatientAppointment(RequestNewPatient data) async {
    try {
      String? _phone;
      String? _ddd;

      var _dataPhone = data.celular == null || data.celular == '' ? null : data.celular;
      var _dataEmail = data.email == null || data.email == '' ? null : data.email;

      if (_dataPhone != null && _dataPhone != '') {
        final dddRegex = RegExp('(\(([1-9]+)\))');
        final ddd = dddRegex.firstMatch(_dataPhone)!.group(2);
        final number = _dataPhone.split(' ').last;
        _ddd = ddd.toString();
        _phone = number.replaceAll('-', '').toString();
      }

      var _model = RequestNewPatient(
        nome: data.nome,
        dataNascimento: data.dataNascimento,
        celular: _phone ?? null,
        ddd: _ddd ?? null,
        email: _dataEmail ?? null,
        modoCadastro: "APP",
      );

      loadingSaveNewPatient.value = true;
      await 0.5.delay();
      final _response = await newPatient.saveNewPatientDatasource(_model);
      loadingSaveNewPatient.value = false;
      if (_response.statusCode != 200) {
        await AppAlert.alertError(title: "Oops!", body: "Não foi possível enviar os dados", seconds: 5);
        return;
      }
      // //Salva numero do paciente
      if (_response.model != null) {
        isValidValue.value = _response.model?.id ?? 0;
        patientId.value = _response.model!.id!;
        valueKeyNewPacient.value = DateTime.now().millisecondsSinceEpoch;
        textFieldNewPatient.text = _response.model?.nome ?? '';

        if (_dataPhone != null) phoneSMSController.text = data.celular ?? '';
        if (_dataEmail != null) sendMailController.text = _dataEmail;

        contactId.value = 0;

        if (_dataPhone != null) {
          newPhonePatient.saveNewPhone(patientId: _response.model!.id!, newNumberPhone: data.celular!, typePhone: 'CEL');
        }
        AppAlert.alertSuccess(title: "Sucesso!", body: "Paciente cadastro com sucesso.", seconds: 10);
      }
      loadingSaveNewPatient.value = false;
      await 2.delay();
      Navigator.pop(Get.context!);
    } catch (e) {
      AppLog.d("Error ao salvar paciente $e", name: 'saveNewPatientAppointment');
      loadingSaveNewPatient.value = false;
      await AppAlert.alertError(title: "Oops!", body: "Não foi possível enviar os dados", seconds: 5);
    }
  }

  // lista de paciente
  void setValuePatient(PatientModelExt _model) async {
    isValidValue.value = _model.id ?? 0;
    patientId.value = _model.id!;
    valueKeyFindPacient.value = DateTime.now().millisecondsSinceEpoch;
    textFieldNamePatientFind.text = _model.nome ?? '';
    contactId.value = 0;
    //set valores para envio
    var phone = _model.telefones != null && _model.telefones!.isNotEmpty ? _model.telefones!.first.formatted(withDDI: false) : '';
    phoneSMSController.text = phone;
    sendMailController.text = _model.email ?? '';
    Get.back();
  }

  _removeString(String? data) {
    if (data == null || data == '') return null;
    var numbers = data.replaceAll(RegExp(r'[^0-9]'), '');
    return numbers;
  }

  // O porque de não incluir o item na lista de uma forma amigavél? Para inserir precisa de um map com index o id do medico
  // O redirecionar parece ser uma opção até mais rápida e segura
  // Pega os dados de _paramsNavigator e redireciona para a tela de lista de compromissos do médico.

  saveSchedule(ParamsToNavigationPage params, ModelFromRequestToSnap requestData) async {
    loadingSave.value = true;
    await 1.delay();
    try {
      var _req = RequestNewMedicalAppointmentSchedule(
        pacienteId: patientId.value,
        titulo: requestData.titulo,
        email: requestData.email,
        emailEnviar: requestData.emailEnviar,
        smsEnviar: requestData.smsEnviar,
        smsTelefone: _removeString(requestData.smsTelefone),
        tipoAtendimento: _isTypeCommitment.value ? 3 : 1,
        agendaStatusId: _isTypeCommitment.value ? 5 : 2,
        contatoId: contactId.value != 0 ? contactId.value.toString() : null,
        modeloCorreioId: requestData.codModeloEmail,
        modeloSmsId: requestData.codModeloSms,
      );

      AppLog.i("saveSchedule Request: ${_req.toMap()}", name: 'b0');

      loadingSave.value = false;

      final _response = await request.saveNewMedicalAppointmentDatasource(_req, _appointmentId.value);
      loadingSave.value = false;
      if (_response.statusCode != 200) {
        await AppAlert.alertError(title: "Oops!", body: "Não foi possível enviar os dados", seconds: 5);
        return;
      }

      if (_response.model != null) {
        // if (typeSendMail.value) await sendNotificationMail(requestData, params.doutorId!);
        // if (typeSendSms.value) await sendNotificationSMS(requestData, params.doutorId!);
        AppAlert.alertSuccess(title: "Sucesso!", body: "Solicitação com sucesso!", seconds: 5);
        emptyDataSendToServer();
        await 1.delay();
        await Get.toNamed(Routes.DOCTOR_COMMITMENT, arguments: params);
      }
      emptyDataSendToServer();
    } catch (e) {
      loadingSave.value = false;
      AppLog.d("Não foi possível salvar a nova consulta $e", name: 'saveSchedule');
      emptyDataSendToServer();
    }
  }

  /// Salva o agendamento para Encaixe, a diferença é que é POST e pode escolher qq dia e horário
  saveScheduleSnap(ParamsToNavigationPage params, ModelFromRequestToSnap requestData) async {
    loadingSave.value = true;
    await 1.delay();
    try {
      //"2021-12-06T15:06:02.740Z"
      //2021-12-08T01:08:00.000Z
      var _req = RequestMedicalAppointmentScheduleSnap(
        agendaConfigId: params.doutorId,
        dataInicio: requestData.dataInicio,
        dataFim: requestData.dataFim,
        horaInicio: requestData.horaInicio,
        horaFim: requestData.horaFim,
        tipoAtendimento: _isTypeCommitment.value ? '3' : '1',
        modeloCorreioId: requestData.codModeloEmail,
        modeloSmsId: requestData.codModeloSms,

        ///ALGUNS PARAMS NAO OBRIGATÓRIOS:
        /// Para a opção do tipo contato não enviar o ID do contato
        pacienteId: _isTypeCommitment.value ? null : patientId.value,
        titulo: requestData.titulo,
        email: requestData.email,
        emailEnviar: requestData.emailEnviar,
        smsEnviar: requestData.smsEnviar,
        smsTelefone: _removeString(requestData.smsTelefone),
        contatoId: contactId.value != 0 ? contactId.value : 0,
      );

      AppLog.w("Request ENCAIXE: ${_req.toMap()}", name: 'b0');

      final _response = await request.saveScheduleSnapDatasource(_req);
      loadingSave.value = false;
      if (_response.statusCode != 200) {
        await AppAlert.alertError(title: "Oops!", body: "Não foi possível enviar os dados", seconds: 5);
        return;
      }

      if (_response.model != null) {
        // if (typeSendMail.value) await sendNotificationMail(requestData, params.doutorId!);
        // if (typeSendSms.value) await sendNotificationSMS(requestData, params.doutorId!);
        AppAlert.alertSuccess(title: "Sucesso!", body: "Solicitação com sucesso!", seconds: 5);
        emptyDataSendToServer();
        await 0.5.delay();
        await Get.toNamed(Routes.DOCTOR_COMMITMENT, arguments: params);
      }
      emptyDataSendToServer();
    } catch (e) {
      loadingSave.value = false;
      AppLog.d("Não foi possível salvar a nova consulta $e", name: 'saveSchedule');
      emptyDataSendToServer();
    }
  }

  // AQUI XXX {assunto: CONFIRMAÇÃO AUTOMÁTICA, modeloCorreioId: 3671200, corpara: 12977449, idAgendamento: 17718, emailPaciente: teste@teste.com, dataEnvio: 2021-12-17T21:00:00, tituloAgenda: Teste, horaEnvio: 21:00:00, corde: 0}

  //sucesso
  // AQUI XXX {assunto: CONFIRMAÇÃO AUTOMÁTICA, modeloCorreioId: 3671200, corpara: 11817253, idAgendamento: 713397193, emailPaciente: carlosmalltec@gmail.com, dataEnvio: 2021-12-17T00:00:00, tituloAgenda: Teste, horaEnvio: 9:00, corde: 0}

  /// Não está em uso devido o ajuste que o Felipe, na mesma request que envia os dados para cadastro já faz o envio da notificação.
  Future<bool> sendNotificationMail(ModelFromRequestToSnap requestData, int doutorId) async {
    try {
      var _date = FormatsDatetime.formatDate(DateTime.parse(requestData.dataInicio.toString()), FormatsDatetime.apiDateFormat);

      var _req = RequestNewMedicalAppointmentNotification(
        assunto: requestData.assuntoModeloEmail,
        modeloCorreioId: requestData.codModeloEmail,
        corde: 0,
        corpara: contactId.value != 0 ? contactId.value : patientId.value,
        idAgendamento: _appointmentId.value,
        emailPaciente: requestData.email,
        dataEnvio: _date,
        horaEnvio: requestData.horaInicio,
        tituloAgenda: requestData.titulo,
      );
      // AppLog.d('AQUI XXX ${_req.toMap()}');
      final _response = await request.sendMailAppointmentDatasource(_req);
      if (_response.statusCode != 200) return false;
      return true;
    } catch (e) {
      loadingSave.value = false;
      AppLog.d("Não foi possível enviar EMAIL  DA nova consulta $e", name: 'sendNotificationMail');
      return false;
    }
  }

  /// O QUE MANDAR NO LUGAR DO idAgendamento E idAgenda ???
  /// PARA ENCAIXE DO TIPO CONTATO NÃO ESTÁ GRAVANDO
  /// O ENCAIXE QUE GRAVEI PARA O DIA 19 AS 4:03 EXIBIIU FOI COMO LISTA DE HORÁRIO E NÃO COMO UM AGENDAMENTO, ESTRANHO
  /// DEPOIS DO HORÁRIO SER EXIBIDO AO ESCOLHER E PREENCHER OS DADOS PARA O AGENDAMENTO CADASTRA CERTINHO.
// DATA: {assunto: Prefeitura de São Paulo, dataEnvio: 2021-12-17T21:00:00, tituloAgenda: Teste, horaEnvio: 21:00:00, modeloSmsId: 3020288, smspara: 12977449, smsPaciente: 11932434243, idAgenda: 17718, smsDe: 0}}
  /// Não está em uso devido o ajuste que o Felipe, na mesma request que envia os dados para cadastro já faz o envio da notificação.
  Future<bool> sendNotificationSMS(ModelFromRequestToSnap requestData, int doutorId) async {
    try {
      var _date = FormatsDatetime.formatDate(DateTime.parse(requestData.dataInicio.toString()), FormatsDatetime.apiDateFormat);
      var _req = RequestNewMedicalAppointmentNotification(
        smsDe: 0,
        modeloSmsId: requestData.codModeloSms,
        smspara: contactId.value != 0 ? contactId.value : patientId.value,
        smsPaciente: requestData.smsTelefone != null ? _removeString(requestData.smsTelefone) : null,
        // idAgenda: doutorId,
        idAgenda: _appointmentId.value != 0 ? _appointmentId.value : null,
        dataEnvio: _date,
        horaEnvio: requestData.horaInicio,
        tituloAgenda: requestData.titulo,
        assunto: requestData.assuntoModeloSms,
      );

      final _response = await request.sendSMSAppointmentDatasource(_req);
      if (_response.statusCode != 200) return false;
      return true;
    } catch (e) {
      loadingSave.value = false;
      AppLog.d("Não foi possível enviar EMAIL  DA nova consulta $e", name: 'sendNotificationSMS');
      return false;
    }
  }

  void formatDateTimeSchedule(DoctorCommitmentExt? _model) {
    _appointmentId.value = _model?.id ?? 0;
    var _time = _model?.hourFormatStart ?? '-';
    var _date = _model?.dataInicioFormat ?? '-';
    dateTimeController.text = "$_date $_time";
  }
}
