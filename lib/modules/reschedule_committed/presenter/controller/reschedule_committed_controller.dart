import 'dart:convert';

import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/doctor_schedule/external/datasource/doctor_schedule_datasource_impl.dart';
import 'package:medicinadireta/modules/doctor_schedule/infra/models/doctor_schedule_ext.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment_headers.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/external/datasource/doctor_commitment_datasource_impl.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/doctor_commitment_ext.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/request_reschedule_default.dart';
import 'package:medicinadireta/modules/reschedule_committed/external/reschedule_datasource_impl.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RescheduleCommittedController extends GetxController {
  final CheckConnectingNetwork connecting;
  final RescheduleDatasourceImpl saveReschedule;
  final DoctorScheduleDatasourceImpl listSchedule;
  final DoctorCommitmentDatasourceImpl listDoctorCommitment;

  RescheduleCommittedController({
    required this.connecting,
    required this.saveReschedule,
    required this.listSchedule,
    required this.listDoctorCommitment,
  });
  @override
  void onInit() {
    savingReschedule.value = false;
    loadingListDoctors.value = false;
    loadingListDoctorCommittedHors.value = false;
    listDoctorSchedule.clear();
    listDoctorCommittedHors.clear();
    super.onInit();
  }

  final RxBool isOpenCar = RxBool(true);
  final testeCheckbox = false;

  openCardPatient() async {
    isOpenCar.value = !isOpenCar.value;
  }

  final RxList<DoctorScheduleExt> listDoctorSchedule = RxList<DoctorScheduleExt>();
  final RxList<DoctorCommitmentExt> listDoctorCommittedHors = RxList<DoctorCommitmentExt>();
  final RxBool savingReschedule = RxBool(false);
  final RxBool savingRescheduleSnap = RxBool(false);
  final RxBool loadingListDoctors = RxBool(false);
  final RxBool loadingListDoctorCommittedHors = RxBool(false);
  final TextEditingController titleRescheduleSanp = TextEditingController();
  final TextEditingController descriptionRescheduleSanp = TextEditingController();

  final RxString selectedItemDoctor = RxString('');
  final Rx<DateTime> initialValueDateTime = Rx<DateTime>(DateTime.now());
  Rx<DateTime?>? initialValueDateTimeRescheduleSnap;
  final RxInt attendanceType = RxInt(0);

  optionsAttendanceType(int? type) {
    if (type != null) {
      attendanceType.value = type;
    }
  }

  /// Unir a data do filtro + a data do card clicado e mostra no campo "DATA DO AGENDAMENTO" para um futuro remarcar com encaixe
  // formatDateTime(ModelDetailsReschedule data) {
  //   if (data.date != null) {
  //     int _hours = 0;
  //     int _minutes = 0;
  //     if (data.hora != null) {
  //       var _time = data.hora?.split(":") ?? [];
  //       if (_time.isNotEmpty) {
  //         _hours = int.parse(_time[0].toString());
  //         _minutes = int.parse(_time[1].toString());
  //       }
  //     }
  //     DateTime _dateFormat = DateTime.parse(data.date.toString()).add(Duration(hours: _hours, minutes: _minutes));
  //     initialValueDateTimeRescheduleSnap?.value = _dateFormat;
  //   }
  // }

  searchListDoctors(ParamsToNavigationPage params) async {
    AppLog.w("searchListDoctors ${params.toMap()}", name: 'searchListDoctors');
    DateTime _dataFinal = params.dataDoFiltroDePesquisa != null ? DateTime.parse(params.dataDoFiltroDePesquisa!) : DateTime.now();
    initialValueDateTime.value = _dataFinal;
    var _name = params.nomeDoMedico != null ? params.nomeDoMedico : '';
    selectedItemDoctor.value = _name!;

    bool _connecting = await connecting.appCheckConnectivity();
    if (!_connecting) {
      loadingListDoctorCommittedHors.value = false;
      listDoctorCommittedHors.clear();
      loadingListDoctors.value = false;
      listDoctorSchedule.clear();
      await AppAlert.alertError(title: "Oops!", body: 'Verifique sua conexão, por favor.', seconds: 5);
      return;
    }
    await _getListDoctors();
    await _getListDoctorCommittedHors(params);
  }

  /// Alteração de outro médico ou a data;
  changeDoctorAndDate(ParamsToNavigationPage params) async {
    AppLog.w("paramsxx ${params.toMap()}", name: 'searchListDoctors');
    await _getListDoctorCommittedHors(params);
  }

  _getListDoctors() async {
    try {
      loadingListDoctors.value = true;
      await 0.300.delay();
      listDoctorSchedule.clear();

      var _params = QueryParameters(count: true, filter: "ativado eq 'S'", orderby: "descricao asc", top: 1000, skip: 0);
      final _response = await listSchedule.doctorScheduleDatasource(_params);
      if (_response.model.length > 0) {
        listDoctorSchedule.addAll(_response.model);
      }
      loadingListDoctors.value = false;
    } catch (e, s) {
      loadingListDoctors.value = false;
      listDoctorSchedule.clear();
      AppLog.d('Problema para listar os médicos $e', name: '_getListDoctors', stackTrace: s);
    }
  }

  _getListDoctorCommittedHors(ParamsToNavigationPage params) async {
    try {
      AppLog.w("paramsxx ${params.toMap()}");
      loadingListDoctorCommittedHors.value = true;
      await 0.300.delay();
      listDoctorCommittedHors.clear();
      var _dataSearch = FormatsDatetime.formatDate(DateTime.now(), FormatsDatetime.yearMonthDay);
      var _dataFinal = params.dataDoFiltroDePesquisa != null ? params.dataDoFiltroDePesquisa : _dataSearch;

      var _filter = "agendaconfigId eq ${params.doutorId} and agendaStatusId eq 1 and agendaStatusId ne 9";
      var _params = ParamsDoctorCommitment(count: true, filter: _filter, orderBy: "horaInicio asc", expand: "Paciente");
      // var _headers = ParamsDoctorCommitmentHeaders(dataInicio: _dataFinal!, dataFim: _dataFinal, profissionalId: params.profissionalId!);
      var _headers = ParamsDoctorCommitmentHeaders(dataInicio: _dataFinal!, dataFim: _dataFinal);

      final _response = await listDoctorCommitment.doctorCommitmentDatasource(_params, _headers);
      if (_response.model.length > 0) listDoctorCommittedHors.addAll(_response.model);

      loadingListDoctorCommittedHors.value = false;
    } catch (e, s) {
      loadingListDoctorCommittedHors.value = false;
      listDoctorCommittedHors.clear();
      AppLog.d('Problema para listar os médicos $e', name: '_getListDoctors', stackTrace: s);
    }
  }

  // saveRescheduleServer(RequestReschedule request) async {
  //   await _saveReschedule(request);
  // }

  saveRescheduleServer(RequestReschedule request, int idCommitted, ParamsToNavigationPage params) async {
    try {
      bool _connecting = await connecting.appCheckConnectivity();
      savingReschedule.value = true;
      await 1.delay();
      if (!_connecting) {
        await AppAlert.alertError(title: "Oops!", body: 'Verifique sua conexão, por favor.', seconds: 5);
        savingReschedule.value = false;
        return;
      }
      var _request = RequestRescheduleDefault(remarcar: request);
      // AppLog.w("warning: ${_request.toMap()}");
      final _response = await saveReschedule.saveRescheduleDatasource(_request, idCommitted);

      if (_response.statusCode != 204) {
        var _msg = 'Não foi possível remarcar';
        var _jsonEncode = jsonEncode(_response.responseData.toString());
        var _isWarning = _jsonEncode.contains('value');
        // AppLog.w('_jsonEncode $_jsonEncode _isWarning: $_isWarning ');

        if (_isWarning) {
          // AppLog.w('_jsonDecode ${_response.responseData['value']}');
          _msg = _response.responseData['value'];
        }

        AppAlert.alertWarning(title: 'Ops!', body: _msg, seconds: 10);
        savingReschedule.value = false;
        return;
      }
      savingReschedule.value = false;
      await AppAlert.alertSuccess(title: "Sucesso!", body: 'Agendamento remarcado com sucesso.', seconds: 5);
      await 1.delay();
      await Get.offNamed(Routes.DOCTOR_COMMITMENT, arguments: params);
    } catch (e, s) {
      savingReschedule.value = false;
      AppLog.d('Problema para listar os médicos $e', name: '_getListDoctors', stackTrace: s);
      await AppAlert.alertError(title: "Oops!", body: 'Não foi possível remarcar', seconds: 5);
    }
  }

  cleanFieldsRescheduleSnap() {
    initialValueDateTimeRescheduleSnap?.value = null;
    descriptionRescheduleSanp.clear();
    attendanceType.value = 0;
    titleRescheduleSanp.clear();
  }

  saveRescheduleSnap(RequestRescheduleSnap request, int idCommitted, ParamsToNavigationPage params) async {
    try {
      bool _connecting = await connecting.appCheckConnectivity();
      savingRescheduleSnap.value = true;
      await 0.500.delay();
      if (!_connecting) {
        await AppAlert.alertError(title: "Oops!", body: 'Verifique sua conexão, por favor.', seconds: 5);
        savingRescheduleSnap.value = false;
        return;
      }
      var _request = RequestRescheduleDefault(remarcarEncaixe: request);
      AppLog.w("_request remarcar encaixe ${_request.toMap()}");
      final _response = await saveReschedule.saveRescheduleSnapDatasource(_request, idCommitted);
      if (_response.statusCode != 204) {
        var _msg = 'Não foi possível Remarcar/Encaixe';
        var _jsonEncode = jsonEncode(_response.responseData.toString());
        var _isWarning = _jsonEncode.contains('value');
        // AppLog.w('_jsonEncode $_jsonEncode _isWarning: $_isWarning ');

        if (_isWarning) {
          // AppLog.w('_jsonDecode ${_response.responseData['value']}');
          _msg = _response.responseData['value'];
        }

        AppAlert.alertWarning(title: 'Ops!', body: _msg, seconds: 10);
        savingRescheduleSnap.value = false;
        return;
      }
      savingRescheduleSnap.value = false;
      await AppAlert.alertSuccess(title: "Sucesso!", body: 'Remarcar/Encaixe com sucesso.', seconds: 5);
      await 1.delay();
      cleanFieldsRescheduleSnap();
      await Get.offNamed(Routes.DOCTOR_COMMITMENT, arguments: params);
    } catch (e, s) {
      savingRescheduleSnap.value = false;
      AppLog.d('Problema para listar os médicos $e', name: '_saveRescheduleSnap', stackTrace: s);
      await AppAlert.alertError(title: "Oops!", body: 'Não foi possível Remarcar/Encaixe', seconds: 5);
    }
  }
}
