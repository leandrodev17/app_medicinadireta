import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/models/request/headers.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/external/datasource/doctor_schedule_datasource_and_patient_impl.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/infra/models/doctor_schedule_and_patient_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorScheduleAndPatientController extends GetxController {
  final DoctorScheduleDatasourceAndPatientImpl requestServer;
  final CheckConnectingNetwork checkConnecting;
  DoctorScheduleAndPatientController({required this.requestServer, required this.checkConnecting});

  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);
  final RxList<DoctorScheduleAndPatientExt> listDoctorScheduleAndPatient = RxList<DoctorScheduleAndPatientExt>();
  final Rx<DateTime> selectedDateDoctorAndPatient = Rx<DateTime>(DateTime.now());
  final RxBool isLoadingPaginationAndPatient = RxBool(false);
  final RxString _dataSearchAndPatient = RxString(FormatsDatetime.formatDate(DateTime.now(), FormatsDatetime.yearMonthDay));

  final _oldDataSearchAndPatient = FormatsDatetime.formatDate(DateTime.now(), FormatsDatetime.yearMonthDay);

  static const _loadMorePageConst = 0.8;
  static const _top = 20;

  final RxInt _limit = RxInt(_top);
  final RxInt _skip = RxInt(0);

  @override
  void onInit() async {
    await getFirstPageAndPatient(true);
    super.onInit();
  }

  @override
  void onClose() {
    isLoadingPaginationAndPatient.value = false;
    super.onClose();
  }

  selectDateTimeCalendarAndPatient(BuildContext context) async {
    var _firstDate = DateTime.now().subtract(const Duration(days: 730));
    var _lastDate = DateTime(2050);
    var _initialDate = DateTime.now();
    final _date = await showDatePicker(context: context, firstDate: _firstDate, lastDate: _lastDate, initialDate: _initialDate);
    if (_date != null) {
      isLoading.value = AppLoadingStatus.shimmerLoading;
      listDoctorScheduleAndPatient.clear();
      selectedDateDoctorAndPatient.value = _date;
      _skip.value = 0;
      _limit.value = _top;
      _dataSearchAndPatient.value = FormatsDatetime.formatDate(_date, FormatsDatetime.yearMonthDay);
      await _getPageAndPatient();
    }
  }

  selectDateTimeAndPatient(DateTime dateSearch) async {
    _dataSearchAndPatient.value = FormatsDatetime.formatDate(dateSearch, FormatsDatetime.yearMonthDay);
    isLoading.value = AppLoadingStatus.shimmerLoading;
    listDoctorScheduleAndPatient.clear();
    _skip.value = 0;
    _limit.value = _top;
    await _getPageAndPatient();
  }

  getFirstPageAndPatient([isFirst = false]) async {
    if (isFirst) {
      isLoading.value = AppLoadingStatus.shimmerLoading;
    } else {
      isLoading.value = AppLoadingStatus.fullLoading;
    }
    _dataSearchAndPatient.value = _oldDataSearchAndPatient;
    selectedDateDoctorAndPatient.value = DateTime.now();

    listDoctorScheduleAndPatient.clear();
    _skip.value = 0;
    _limit.value = _top;
    isLoadingPaginationAndPatient.value = false;
    await _getPageAndPatient(isFirst);
  }

  onScrollAndPatient(double scrollPosition, double scrollMax) async {
    if (isLoadingPaginationAndPatient.value) return;
    if (scrollPosition > scrollMax * _loadMorePageConst) {
      isLoadingPaginationAndPatient.value = false;
      getNextPageAndPatient();
    }
  }

  getNextPageAndPatient() async {
    if (isLoading.value != AppLoadingStatus.notLoading) return;
    isLoading.value = AppLoadingStatus.nextPageLoading;
    await _getPageAndPatient();
  }

  swipeRefreshAndPatient() async {
    isLoadingPaginationAndPatient.value = false;
    await getFirstPageAndPatient(true);
  }

  _getPageAndPatient([isFirst = false]) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      var _params = QueryParameters(
        expand: "Paciente, AgendaConfig",
        orderby: "horaInicio",
        filter: "AgendaConfig/ativado eq 'S' and agendaStatusId ne 1 and agendaStatusId ne 9 and agendaStatusId ne 4 and agendaStatusId ne 11",
        top: _limit.value,
        skip: _skip.value,
      );

      var _headers = Headers(dataInicio: _dataSearchAndPatient.value, dataFim: _dataSearchAndPatient.value);

      final _response = await requestServer.doctorScheduleAndPatientDatasource(_params, _headers);

      if (_response.statusCode != 200) {
        await AppAlert.alertError(title: "Oops!", body: 'Todos os itens já foram listados', seconds: 5);
        isLoading.value = AppLoadingStatus.notLoading;
        return;
      }

      // // No evita ficar enviando consulta no scroll
      if (_response.model.length == 0 && listDoctorScheduleAndPatient.isNotEmpty) {
        isLoadingPaginationAndPatient.value = true;
        await AppAlert.alertSuccess(title: "Oops!", body: 'Todos os itens já foram listados', seconds: 5);
      }

      if (_response.model.length > 0) listDoctorScheduleAndPatient.addAll(_response.model);

      isLoading.value = AppLoadingStatus.notLoading;
      _skip.value = _skip.value + _limit.value;
    } catch (e) {
      AppLog.d('NÃO FOI POSSÍVEL LISTA OS MEDICOS E SEUS PACIENTES ===> $e', name: '_getPageAndPatient');
      isLoading.value = AppLoadingStatus.notLoading;
      isLoadingPaginationAndPatient.value = false;
      await AppAlert.alertError(title: "Oops!", body: 'Não foi possível listar os dados', seconds: 5);
    }
  }
}
