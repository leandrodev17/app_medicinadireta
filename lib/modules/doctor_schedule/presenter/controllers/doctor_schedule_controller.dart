import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/doctor_schedule/external/datasource/doctor_schedule_datasource_impl.dart';
import 'package:medicinadireta/modules/doctor_schedule/infra/models/doctor_schedule_ext.dart';

import 'package:get/get.dart';

class DoctorScheduleController extends GetxController {
  final DoctorScheduleDatasourceImpl requestServer;
  final CheckConnectingNetwork checkConnecting;
  DoctorScheduleController({required this.requestServer, required this.checkConnecting});

  final RxBool loading = RxBool(false);

  final RxBool isLoadingPagination = RxBool(false);

  final RxList<DoctorScheduleExt> listDoctorSchedule = RxList<DoctorScheduleExt>();

  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  static const _loadMorePageConst = 0.8;
  static const _top = 20;

  final RxInt _limit = RxInt(_top);
  final RxInt _skip = RxInt(0);

  int formatColor(String? data) {
    if (data == null) return 0xffFA775D;
    String? cor = data.replaceAll('#', '').toUpperCase();
    String? string = cor != '' ? "0xFF$cor" : null;
    return string != null ? int.parse(string.toString()) : 0xffFA775D;
  }

  getFirstPage([isFirst = false]) async {
    if (isFirst) {
      isLoading.value = AppLoadingStatus.shimmerLoading;
    } else {
      isLoading.value = AppLoadingStatus.fullLoading;
    }
    listDoctorSchedule.clear();
    _skip.value = 0;
    _limit.value = _top;
    isLoadingPagination.value = false;
    await _getPage(isFirst);
  }

  onScroll(double scrollPosition, double scrollMax) async {
    if (isLoadingPagination.value) return;
    if (scrollPosition > scrollMax * _loadMorePageConst) {
      isLoadingPagination.value = false;
      getNextPage();
    }
  }

  getNextPage() async {
    if (isLoading.value != AppLoadingStatus.notLoading) return;
    isLoading.value = AppLoadingStatus.nextPageLoading;
    await _getPage();
  }

  swipeRefresh() async {
    isLoadingPagination.value = false;
    await getFirstPage(true);
  }

  _getPage([isFirst = false]) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      var _params = QueryParameters(
        count: true,
        filter: "ativado eq 'S'",
        orderby: "descricao asc",
        top: _limit.value,
        skip: _skip.value,
      );

      if (isFirst) listDoctorSchedule.clear();

      final _response = await requestServer.doctorScheduleDatasource(_params);
      if (_response.statusCode != 200) {
        await AppAlert.alertError(title: "Oops!", body: 'Todos os itens já foram listados', seconds: 5);
        isLoading.value = AppLoadingStatus.notLoading;
        return;
      }

      // No evita ficar enviando consulta no scroll
      if (_response.model.length == 0 && listDoctorSchedule.isNotEmpty) {
        isLoadingPagination.value = true;
        await AppAlert.alertSuccess(title: "Oops!", body: 'Todos os itens já foram listados', seconds: 5);
      }

      if (_response.model.length > 0) {
        listDoctorSchedule.addAll(_response.model);
      }

      isLoading.value = AppLoadingStatus.notLoading;
      _skip.value = _skip.value + _limit.value;
    } catch (e) {
      AppLog.d('ERROR CONTROLLER DOCTOR SCHEDULE ===> $e');
      isLoading.value = AppLoadingStatus.notLoading;
      isLoadingPagination.value = false;
      await AppAlert.alertError(title: "Oops!", body: 'Não foi possível listar os dados', seconds: 5);
    }
  }

  @override
  void onInit() async {
    // await getFirstPage(true);
    super.onInit();
  }

  @override
  void onClose() {
    isLoadingPagination.value = false;
    super.onClose();
  }
}
