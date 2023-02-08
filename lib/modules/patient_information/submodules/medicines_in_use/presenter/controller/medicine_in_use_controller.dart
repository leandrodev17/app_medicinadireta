import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/external/datasource/medicines_in_use_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/infra/models/medicines_in_use_ext.dart';
import 'package:get/get.dart';

class MedicineInUseController extends GetxController {
  final MedicinesInUseDatasourceImpl request;
  MedicineInUseController(this.request);

  static const _loadMorePageConst = 0.8;
  static const _top = 20;

  final RxInt _limit = RxInt(_top);
  final RxInt _skip = RxInt(0);
  final RxBool isLoadingPagination = RxBool(false);

  final RxList<MedicinesInUseExt> listMedicineInUse = RxList<MedicinesInUseExt>();

  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  @override
  void onInit() {
    super.onInit();
  }

  getFirstPage({isFirst = false, required int patientId}) async {
    if (isFirst) {
      isLoading.value = AppLoadingStatus.shimmerLoading;
    } else {
      isLoading.value = AppLoadingStatus.fullLoading;
    }
    listMedicineInUse.clear();
    isLoadingPagination.value = false;
    _skip.value = 0;
    _limit.value = _top;
    await _getFindMedicinesInUse(patientId);
  }

  onScroll(double scrollPosition, double scrollMax, int patientId) async {
    if (isLoadingPagination.value) return;
    if (scrollPosition > scrollMax * _loadMorePageConst) {
      isLoadingPagination.value = false;
      getNextPage(patientId);
    }
  }

  getNextPage(int patientId) async {
    if (isLoading.value != AppLoadingStatus.notLoading) return;
    isLoading.value = AppLoadingStatus.nextPageLoading;
    await _getFindMedicinesInUse(patientId);
  }

  swipeRefresh(int patientId) async {
    isLoadingPagination.value = false;
    await getFirstPage(isFirst: true, patientId: patientId);
  }

  _getFindMedicinesInUse(int patientId) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      var _parameters = QueryParameters(orderby: "dataEvento desc", expand: "Medicamento", top: _limit.value, skip: _skip.value);

      final _response = await request.findMedicinesInUseDatasource(_parameters, patientId);
      if (_response.statusCode != 200) {
        await AppAlert.alertWarning(title: 'Oops!', body: 'Não foi possível listar os dados');
        isLoading.value = AppLoadingStatus.notLoading;
        return;
      }

      // No evita ficar enviando consulta no scroll
      if (_response.model.length == 0 && listMedicineInUse.isNotEmpty) {
        isLoadingPagination.value = true;
        AppAlert.alertSuccess(title: 'Oops!', body: 'Todos os itens já foram listados');
      }

      if (_response.model.isNotEmpty) listMedicineInUse.addAll(_response.model);

      isLoading.value = AppLoadingStatus.notLoading;
      _skip.value = _skip.value + _limit.value;
    } catch (e) {
      AppLog.d('Não foi possível listar os Medicos e usuários $e', name: '_getFindMedicinesInUse');
      isLoading.value = AppLoadingStatus.notLoading;
      isLoadingPagination.value = false;
      AppAlert.alertError(title: 'Oops!', body: 'Não foi possível listar os dados');
    }
  }
}
