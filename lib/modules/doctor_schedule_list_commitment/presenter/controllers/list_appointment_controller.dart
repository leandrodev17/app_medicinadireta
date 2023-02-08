import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment_headers.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/external/datasource/doctor_commitment_datasource_impl.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/doctor_commitment_ext.dart';

import 'package:get/get.dart';

class ListAppointmentController extends GetxController {
  final DoctorCommitmentDatasourceImpl requestServer;
  final SharedPreferencesHelper sharedPreferences;
  final CheckConnectingNetwork checkConnecting;

  ListAppointmentController({
    required this.requestServer,
    required this.sharedPreferences,
    required this.checkConnecting,
  });

  final RxBool loading = RxBool(false);
  final RxList<DoctorCommitmentExt> listAppointment = RxList<DoctorCommitmentExt>();
  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);
  final RxString _dataSearch = RxString(FormatsDatetime.formatDate(DateTime.now(), FormatsDatetime.yearMonthDay));

  final Rx<DateTime> selectedDateAppointment = Rx<DateTime>(DateTime.now());

  getFirstPage(ParamsToNavigationPage params, DateTime dateTime) async {
    selectedDateAppointment.value = dateTime;
    _dataSearch.value = FormatsDatetime.formatDate(dateTime, FormatsDatetime.yearMonthDay);
    isLoading.value = AppLoadingStatus.shimmerLoading;
    listAppointment.clear();
    await _getPage(params);
  }

  swipeRefresh(ParamsToNavigationPage params, DateTime dateTime) async {
    _dataSearch.value = FormatsDatetime.formatDate(dateTime, FormatsDatetime.yearMonthDay);
    await getFirstPage(params, dateTime);
  }

  _getPage(ParamsToNavigationPage params) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      final isConnecting = await checkConnecting.appCheckConnectivity();
      var _filter = "agendaconfigId eq ${params.doutorId} and agendaStatusId eq 1 and agendaStatusId ne 9";
      var _params = ParamsDoctorCommitment(count: true, filter: _filter, orderBy: "horaInicio asc", expand: "Paciente");
      var _headers = ParamsDoctorCommitmentHeaders(dataInicio: _dataSearch.value, dataFim: _dataSearch.value, profissionalId: params.profissionalId!);

      if (isConnecting) {
        final _response = await requestServer.doctorCommitmentDatasource(_params, _headers);
        if (_response.statusCode != 200) {
          await AppAlert.alertError(title: "Oops!", body: 'Não foi possível listar os dados', seconds: 5);
        }

        if (_response.model.length > 0) listAppointment.addAll(_response.model);
      }
      if (!isConnecting) {
        isLoading.value = AppLoadingStatus.notConnecting;
        await AppAlert.alertError(title: "Oops!", body: 'Verifique sua conexão, por favor.', seconds: 5);
      } else {
        isLoading.value = AppLoadingStatus.notLoading;
      }
    } catch (e) {
      AppLog.d('ERROR CONTROLLER DOCTOR COMMITMENT ===> $e', name: 'getPageAppointment');
      isLoading.value = AppLoadingStatus.notLoading;
      await AppAlert.alertError(title: "Oops!", body: 'Não foi possível listar os dados', seconds: 5);
    }
  }
}
