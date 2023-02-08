import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/binding_from_initial/commons_controller.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/models/phones/patient_model_phone_ext.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment_headers.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/commitement_details.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/external/datasource/doctor_commitment_datasource_impl.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/doctor_commitment_ext.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DoctorCommitmentController extends GetxController {
  final DoctorCommitmentDatasourceImpl requestServer;
  final SharedPreferencesHelper sharedPreferences;
  final CheckConnectingNetwork checkConnecting;
  final CommonsController? commons;

  DoctorCommitmentController({
    required this.requestServer,
    required this.sharedPreferences,
    required this.checkConnecting,
    this.commons,
  });

  final RxBool loading = RxBool(false);
  final RxBool loadingPatientPhone = RxBool(false);

  final RxString _dataSearch = RxString(FormatsDatetime.formatDate(DateTime.now(), FormatsDatetime.yearMonthDay));

  // final RxString telefonePatient = RxString('');

  // final RxList<DoctorCommitmentExt> listDoctorCommitment = RxList<DoctorCommitmentExt>();
  // final RxMap<int?, PatientPhoneExt?> listPatientPhone = RxMap<int?, PatientPhoneExt?>();
  final RxList<CommitementDetails> listPatientDetails = RxList<CommitementDetails>();

  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  final Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  selectDateTime(BuildContext context, ParamsToNavigationPage params) async {
    var _firstDate = DateTime.now().subtract(const Duration(days: 730));
    var _lastDate = DateTime(2050);
    var _initialDate = DateTime.now();
    final _date = await showDatePicker(context: context, firstDate: _firstDate, lastDate: _lastDate, initialDate: _initialDate);
    if (_date != null) {
      isLoading.value = AppLoadingStatus.shimmerLoading;
      listPatientDetails.clear();
      selectedDate.value = _date;
      _dataSearch.value = FormatsDatetime.formatDate(_date, FormatsDatetime.yearMonthDay);
      await _getPage(params);
    }
  }

  // PREPARA OS DADOS DO PARAMETRO E ENVIA PARA A LISTA DE HORÁRIO LIVRE PARA AGENDAMENTO,
  // ESSA SOLUÇÃO É PARA SEMPRE ENVIAR A DATA SELECIONADA NA LISTA DE PACIENTES E DIRECIONAR COM ESSA DATA JÁ OK PARA LISTA DE HORÁRIOS
  onPressedAppointment(ParamsToNavigationPage data) async {
    //ParamsNavigator(doctorId: _model.id, nameDoctor: _model.descricao, profissionalId: _model.profissionalId);
    var _params = ParamsToNavigationPage(
      /// ESSE DADOS QUE VEM DESDE A LISTA DE MÉDICOS
      nomeDoMedico: data.nomeDoMedico,
      doutorId: data.doutorId,
      profissionalId: data.profissionalId,

      /// DADOS QUE SERÃO ALTERADOS NESTE CONTEXTO
      dataDoFiltroDePesquisa: _dataSearch.value,
    );
    await Get.toNamed(Routes.LIST_APPOINTMENT, arguments: _params);
  }

  searchByDayCommitment(ParamsToNavigationPage params, DateTime dateSearch) async {
    _dataSearch.value = FormatsDatetime.formatDate(dateSearch, FormatsDatetime.yearMonthDay);
    commons?.dateTimeNewMedicalAppointment.value = dateSearch;
    isLoading.value = AppLoadingStatus.shimmerLoading;
    listPatientDetails.clear();
    await _getPage(params);
  }

  Future<PatientModelPhoneExt> getPatientPhone({int? patientId}) async {
    PatientModelPhoneExt _telefonePatient = PatientModelPhoneExt();
    try {
      var _filter = "tipo eq 'CEL' and ativado eq 'S'";
      var _params = ParamsDoctorCommitment(count: true, filter: _filter, orderBy: "data desc", top: 1);

      final _response = await requestServer.patientDatasource(_params, patientId!);
      if (_response.statusCode == 200) {
        if (_response.model.isNotEmpty) {
          _telefonePatient = _response.model.first;
        }
      }
      return _telefonePatient;
    } catch (e) {
      return _telefonePatient;
    }
  }

  openItemCardFromList(int indexList) {
    var _modelOld = listPatientDetails[indexList];
    var _modelUpdate = _modelOld;
    _modelUpdate = _modelUpdate.copyWith(openCardPatient: !_modelUpdate.openCardPatient);
    listPatientDetails.removeAt(indexList);
    listPatientDetails.insert(indexList, _modelUpdate);
    // print("indexList $indexList");
  }

  getFirstPage(ParamsToNavigationPage params) async {
    // AppLog.d("params ${params.toMap()}", name: 'b0');
    var _selectedDate = params.dataDoFiltroDePesquisa != null ? DateTime.parse(params.dataDoFiltroDePesquisa!) : DateTime.now();

    _dataSearch.value = FormatsDatetime.formatDate(_selectedDate, FormatsDatetime.yearMonthDay);
    isLoading.value = AppLoadingStatus.shimmerLoading;
    listPatientDetails.clear();
    await _getPage(params);
  }

  swipeRefresh(ParamsToNavigationPage params) async {
    await getFirstPage(params);
  }

  String _formatHours(String hours) {
    try {
      if (hours == '') return "--";
      if (hours == "PT0S") return "00:00";
      return FormatsDatetime.formatTime(hours);
    } catch (e) {
      print("Erro ao converter data: $e");
      return "--";
    }
  }

  _getPage(ParamsToNavigationPage params) async {
    try {
      listPatientDetails.clear();
      await Future.delayed(Duration(seconds: 1));
      final isConnecting = await checkConnecting.appCheckConnectivity();
      var _filter = "agendaconfigId eq ${params.doutorId} and agendaStatusId ne 1 and agendaStatusId ne 9 and agendaStatusId ne 4 and agendaStatusId ne 11";
      var _params = ParamsDoctorCommitment(count: true, filter: _filter, orderBy: "horaInicio asc", expand: "Paciente, Contato");
      var _headers = ParamsDoctorCommitmentHeaders(dataInicio: _dataSearch.value, dataFim: _dataSearch.value, profissionalId: params.profissionalId!);

      if (isConnecting) {
        final _response = await requestServer.doctorCommitmentDatasource(_params, _headers);
        if (_response.statusCode != 200) {
          await AppAlert.alertError(title: "Oops!", body: 'Não foi possível listar os dados', seconds: 5);
        }

        if (_response.model.isNotEmpty) {
          for (var i = 0; i < _response.model.length; i++) {
            DoctorCommitmentExt _model = _response.model[i];

            String? _descricao = _model.agendaStatus?.descricao?.toUpperCase() ?? null;
            String? _cor = _model.agendaStatus?.cor?.replaceAll('#', '').toUpperCase() ?? null;
            String? _titulo = _model.titulo?.toUpperCase() ?? null;

            String? _phone;
            String? _mail;
            String? _name;
            String? _age;
            int? _numberProntuario;
            int? _organizacaoId;

            String? _string = _cor != null && _cor != '' ? "0xFF$_cor" : null;
            int? _corFormat = _string != null ? int.parse(_string.toString()) : null;

            _name = _model.tipoAtendimento == "3" ? (_model.contato?.nome ?? '--') : '--';

            if (_model.paciente != null) {
              //TODO LISTAR O TELEFONE JUNTO COM O RESULTADO DA LISTA DE AGENDAMENTOS
              var _findPhonePatient = await getPatientPhone(patientId: _model.paciente!.id);
              var _ddi = _findPhonePatient.ddi != null ? "+${_findPhonePatient.ddi}" : '';
              var _ddd = _findPhonePatient.ddd != null ? "(${_findPhonePatient.ddd})" : '';
              var _numero = _findPhonePatient.numero != null ? _findPhonePatient.numero : '';

              _phone = "$_ddi $_ddd $_numero";

              List<String> _idade = _model.paciente?.idade != null ? _model.paciente!.idade!.split(" ").toList() : [];
              _age = _idade.first;

              _mail = _model.paciente?.email?.toLowerCase();
              _name = _model.paciente?.nome?.toLowerCase();
              _numberProntuario = _model.paciente?.prontuario;
              _organizacaoId = _model.paciente?.organizacaoId;
            }

            var _patientDetails = CommitementDetails(
              descricao: _descricao,
              cor: _corFormat,
              titulo: _titulo,
              age: _age,
              // hourFormatStart: _model.hourFormatStart,
              hourFormatStart: _formatHours(_model.horaInicio ?? ''),
              phone: _phone,
              id: _model.id,
              mail: _mail,
              name: _name,
              numberProntuario: _numberProntuario,
              pacienteId: _model.pacienteId,
              observacao: _model.observacoes,
              agendaStatusId: _model.agendaSalaId,
              profissionalId: _model.profissionalId,
              agendaConfigId: _model.agendaConfigId,
              organizacaoId: _organizacaoId,
              openCardPatient: false,
              tipoAtendimento: _model.tipoAtendimento,
              haveInfoPatient: _model.tipoAtendimento == "3",
            );
            listPatientDetails.add(_patientDetails);
          }
        }
      }
      if (!isConnecting) {
        isLoading.value = AppLoadingStatus.notConnecting;
        await AppAlert.alertError(title: "Oops!", body: 'Verifique sua conexão, por favor.', seconds: 5);
      } else {
        isLoading.value = AppLoadingStatus.notLoading;
      }
    } catch (e) {
      AppLog.d('Não foi possível listar os pacientes - $e', name: 'DoctorCommitmentController:_getPage');
      isLoading.value = AppLoadingStatus.notLoading;
      await AppAlert.alertError(title: "Oops!", body: 'Não foi possível listar os dados', seconds: 5);
    }
  }

  int formatColor(String? data) {
    if (data == null) return 0xffFA775D;
    String? cor = data.replaceAll('#', '').toUpperCase();
    String? string = cor != '' ? "0xFF$cor" : null;
    return string != null ? int.parse(string.toString()) : 0xffFA775D;
  }
}
