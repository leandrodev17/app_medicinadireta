import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/financial/external/datasource/financial_datasource_impl.dart';
import 'package:medicinadireta/modules/financial/infra/models/service_order_ext.dart';
import 'package:get/get.dart';

class ServiceOrderController extends GetxController {
  final FinancialDatasourceImpl request;

  ServiceOrderController(this.request);

  final RxList<ServiceOrderExt> listServiceOrder = RxList<ServiceOrderExt>();

  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  @override
  void onInit() async {
    super.onInit();
  }

  getFirstPage(int? patientId) async {
    isLoading.value = AppLoadingStatus.shimmerLoading;
    listServiceOrder.clear();
    await _getFindServiceOrder(patientId);
  }

  _getFindServiceOrder(int? patientId) async {
    try {
      listServiceOrder.clear();
      await Future.delayed(Duration(seconds: 1));
      var _params = QueryParameters(
          expand: "Status, Itens",
          top: 100,
          skip: 0,
          orderby: "id desc",
          filter: "fechado eq 'A'",
      );

      final _response = await request.findServiceOrderDatasource(_params, patientId!);
      if (_response.statusCode != 200) {
        await AppAlert.alertWarning(title: 'Oops!', body: 'Não foi possível listar os dados');
      }

      if (_response.model.isNotEmpty) {
        listServiceOrder.addAll(_response.model);
      }
      isLoading.value = AppLoadingStatus.notLoading;
    } catch (e) {
      AppLog.d('ERROR CONTROLLER SERVICE ORDER ===> $e',name: 'getFindServiceOrder');
      isLoading.value = AppLoadingStatus.notLoading;
      AppAlert.alertError(title: 'Oops!', body: 'Não foi possível listar os dados');
    }
  }

}
