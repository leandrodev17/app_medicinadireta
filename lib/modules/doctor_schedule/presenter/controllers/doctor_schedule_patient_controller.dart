import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/doctor_schedule/external/datasource/doctor_schedule_datasource_impl.dart';
import 'package:medicinadireta/modules/doctor_schedule/infra/models/doctor_schedule_ext.dart';
import 'package:get/get.dart';

class DoctorSchedulePatientController extends GetxController {
  final DoctorScheduleDatasourceImpl requestServer;
  final CheckConnectingNetwork checkConnecting;
  DoctorSchedulePatientController({required this.requestServer, required this.checkConnecting});

  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);
  final RxList<DoctorScheduleExt> listDoctorScheduleAndPatient = RxList<DoctorScheduleExt>();
  final Rx<DateTime> selectedDateDoctorAndPatient = Rx<DateTime>(DateTime.now());
  final RxBool isLoadingPaginationAndPatient = RxBool(false);

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

  getFirstPageAndPatient([isFirst = false]) async {
    if (isFirst) {
      isLoading.value = AppLoadingStatus.shimmerLoading;
    } else {
      isLoading.value = AppLoadingStatus.fullLoading;
    }
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

  swipeRefresh() async {
    isLoadingPaginationAndPatient.value = false;
    await getFirstPageAndPatient(true);
  }

  _getPageAndPatient([isFirst = false]) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      // var _params = QueryParameters(
      //   expand: "Paciente, AgendaConfig",
      //   orderby: "horaInicio",
      //   filter: "AgendaConfig/ativado eq 'S' and agendaStatusId ne 1 and agendaStatusId ne 9 and agendaStatusId ne 4 and agendaStatusId ne 11",
      //   top: _limit.value,
      //   skip: _skip.value,
      // );

      // final _response = await requestServer.doctorScheduleDatasource(_params);
      // if (_response.statusCode != 200) {
      //   await AppAlert.alertError(title: "Oops!", body: 'Todos os itens já foram listados', seconds: 5);
      //   isLoading.value = AppLoadingStatus.notLoading;
      //   return;
      // }

      // // No evita ficar enviando consulta no scroll
      // if (_response.model.length == 0 && listDoctorScheduleAndPatient.isNotEmpty) {
      //   isLoadingPaginationAndPatient.value = true;
      //   await AppAlert.alertSuccess(title: "Oops!", body: 'Todos os itens já foram listados', seconds: 5);
      // }

      // if (_response.model.length > 0) {
      //   listDoctorScheduleAndPatient.addAll(_response.model);
      // }

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
