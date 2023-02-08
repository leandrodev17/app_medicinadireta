import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/models/patient/patient_model_ext.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/financial/external/datasource/financial_datasource_impl.dart';
import 'package:get/get.dart';

class FinancialController extends GetxController {
  final FinancialDatasourceImpl request;

  FinancialController(this.request);

  final RxList<PatientModelExt> listPatientFinancial = RxList<PatientModelExt>();
  final RxList<PatientModelExt> listPatientFinancialSearch = RxList<PatientModelExt>();

  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  static const _loadMorePageConst = 0.8;
  static const _top = 20;

  final RxInt _limit = RxInt(_top);
  final RxInt _skip = RxInt(0);
  final RxBool isLoadingPagination = RxBool(false);

  final RxString searchPatientFinancialName = RxString('');
  final RxBool isLoadingSearchFinancial = RxBool(false);

  @override
  void onInit() async {
    await getFirstPage();
    super.onInit();
  }

  getFirstPage([isFirst = false]) async {
    if (isFirst) {
      isLoading.value = AppLoadingStatus.shimmerLoading;
    } else {
      isLoading.value = AppLoadingStatus.fullLoading;
    }
    listPatientFinancial.clear();
    listPatientFinancialSearch.clear();
    isLoadingPagination.value = false;
    _skip.value = 0;
    _limit.value = _top;
    await _getFindPatientFinancial(isFirst);
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
    await _getFindPatientFinancial();
  }

  swipeRefresh() async {
    isLoadingPagination.value = false;
    await getFirstPage(true);
  }

  RxBool isOpenTextFieldSearchFinancial = RxBool(false);
  openTextFieldSearchFinancial() => isOpenTextFieldSearchFinancial.value = !isOpenTextFieldSearchFinancial.value;

  onChangeSearchPatientFinancial(String data) => searchPatientFinancialName.value = data;

  searchPatient() async {
    try {
      if (searchPatientFinancialName.value == '' || searchPatientFinancialName.value.isEmpty) return null;
      await _getSearchPatientFinancial();
    } catch (e) {
      AppLog.d('Não foi possível localizar o paciente $e', name: 'searchPatient');
    }
  }

  _getSearchPatientFinancial() async {
    try {
      isLoadingSearchFinancial.value = true;
      isLoading.value = AppLoadingStatus.searchLoading;
      listPatientFinancialSearch.clear();
      var _params = QueryParameters(
        select: "id,prontuario,nome,idade,email,dataNascimento,observacoes,fotoBase64",
        expand: "Telefones(\$filter=ativado eq 'S'; \$orderby=data desc; \$count=true)",
        filter: "contains(tolower(nome), '${searchPatientFinancialName.value.toLowerCase()}') eq true",
        top: 20,
        skip: 0,
      );

      final _response = await request.findFinancialDatasource(_params);
      if (_response.statusCode != 200) {
        await AppAlert.alertWarning(title: 'Oops!', body: 'Não foi possível listar os dados');
        isLoading.value = AppLoadingStatus.notLoading;
        return;
      }
      if (_response.model?.isNotEmpty ?? false) listPatientFinancialSearch.addAll(_response.model!);
      isLoadingSearchFinancial.value = false;
    } catch (e) {
      isLoading.value = AppLoadingStatus.notLoading;
      AppLog.d('Não foi possível localizar o paciente $e', name: '_getSearchPatient');
    }
  }

  _getFindPatientFinancial([isFirst = false]) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      var _params = QueryParameters(
          select: "id,prontuario,nome,idade,email,dataNascimento,observacoes,fotoBase64",
          expand: "Telefones(\$filter=ativado eq 'S'; \$orderby=data desc; \$count=true)",
          top: _limit.value,
          skip: _skip.value);

      final _response = await request.findFinancialDatasource(_params);
      if (_response.statusCode != 200) {
        await AppAlert.alertWarning(title: 'Oops!', body: 'Não foi possível listar os dados');
        isLoading.value = AppLoadingStatus.notLoading;
        return;
      }

      // No evita ficar enviando consulta no scroll
      
      if (_response.model?.length == 0 && listPatientFinancial.isNotEmpty) {
        isLoadingPagination.value = true;
        AppAlert.alertSuccess(title: 'Oops!', body: 'Todos os itens já foram listados');
      }

      if (_response.model?.isNotEmpty ?? false) listPatientFinancial.addAll(_response.model!);

      isLoading.value = AppLoadingStatus.notLoading;
      _skip.value = _skip.value + _limit.value;
    } catch (e) {
      AppLog.d('ERROR CONTROLLER PATIENT ===> $e', name: 'getFindPatientFinancial');
      isLoading.value = AppLoadingStatus.notLoading;
      isLoadingPagination.value = false;
      AppAlert.alertError(title: 'Oops!', body: 'Não foi possível listar os dados');
    }
  }
}
