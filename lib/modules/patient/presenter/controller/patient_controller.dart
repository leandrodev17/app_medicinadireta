import 'package:get/get.dart';

import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/models/patient/patient_model_ext.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient/external/datasource/patient_datasource_impl.dart';

class PatientController extends GetxController {
  final PatientDatasourceImpl request;

  PatientController({required this.request});

  final RxList<PatientModelExt> listPatient = RxList<PatientModelExt>();
  final RxList<PatientModelExt> listPatientSearch = RxList<PatientModelExt>();

  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  RxBool isOpenTextFieldSearch = RxBool(false);
  RxBool isLoadingSearch = RxBool(false);

  static const _loadMorePageConst = 0.9;
  static const _top = 100;

  final RxInt _limit = RxInt(_top);
  final RxInt _skip = RxInt(0);
  final RxBool isLoadingPagination = RxBool(false);
  final RxBool showLoadingData = RxBool(false);
  final RxString searchPatientName = RxString('');

  openTextFieldSearch() => isOpenTextFieldSearch.value = !isOpenTextFieldSearch.value;

  @override
  void onInit() async {
    // await getFirstPage();
    super.onInit();
  }

  _initData() {
    listPatientSearch.clear();
    listPatient.clear();
    isLoadingPagination.value = false;
    _skip.value = 0;
    _limit.value = _top;
  }

  getFirstPage([isFirst = false]) async {
    // print('showLoadingData.value ${showLoadingData.value}');
    if (showLoadingData.value) return null;
    if (isFirst) {
      isLoading.value = AppLoadingStatus.shimmerLoading;
    } else {
      isLoading.value = AppLoadingStatus.fullLoading;
    }
    _initData();
    showLoadingData.value = true;
    await _getFindPatient(isFirst);
  }

  onScroll(double scrollPosition, double scrollMax) async {
    if (isLoadingPagination.value) return;
    if (scrollPosition > scrollMax * _loadMorePageConst) {
      isLoadingPagination.value = false;
      await getNextPage();
    }
  }

  getNextPage() async {
    if (isLoading.value != AppLoadingStatus.notLoading) return;
    isLoading.value = AppLoadingStatus.nextPageLoading;
    await _getFindPatient();
  }

  swipeRefresh() async {
    isLoading.value = AppLoadingStatus.shimmerLoading;
    _initData();
    await _getFindPatient();
  }

  onChangeSearchPatient(String data) => searchPatientName.value = data;

  searchPatient({bool findPatientToNewAppointment = false}) async {
    try {
      if (searchPatientName.value == '' || searchPatientName.value.isEmpty) return null;
      await _getSearchPatient(findPatientToNewAppointment: findPatientToNewAppointment);
    } catch (e) {
      AppLog.d('Não foi possível localizar o paciente $e', name: 'searchPatient');
    }
  }

  _getSearchPatient({bool findPatientToNewAppointment = false}) async {
    //findPatientToNewAppointment = significa que deve buscar somente pacientes ativos
    try {
      isLoadingSearch.value = true;
      isLoading.value = AppLoadingStatus.searchLoading;
      listPatientSearch.clear();
      var params = const QueryParameters(
        select: "id,prontuario,nome,idade,email,dataNascimento,observacoes,fotoBase64",
        expand: "Telefones(\$filter=ativado eq 'S'; \$orderby=data desc; \$count=true)",
        orderby: "nome asc",
      );

      final response = await request.findPatientDatasource(params, limit: 100, offset: 0, nome: "'${searchPatientName.value.toLowerCase()}'");
      if (response.statusCode != 200 && response.statusCode != 404) {
        await AppAlert.alertWarning(title: 'Oops!', body: 'Não foi possível listar os dados');
        isLoading.value = AppLoadingStatus.notLoading;
        return;
      }
      if (response.model != null) listPatientSearch.addAll(response.model!);
      isLoadingSearch.value = false;
      // isLoading.value = AppLoadingStatus.notLoading;
    } catch (e) {
      isLoading.value = AppLoadingStatus.notLoading;
      AppLog.d('Não foi possível localizar o paciente $e', name: '_getSearchPatient');
    }
  }

  _getFindPatient([isFirst = false]) async {
    try {
      // await Future.delayed(Duration(seconds: 1));
      var _params = QueryParameters(
          select: "id,prontuario,nome,idade,email,dataNascimento,observacoes,fotoBase64",
          expand: "Telefones(\$filter=ativado eq 'S'; \$orderby=data desc; \$count=true)",
          filter: "ativado eq 'S'",
          orderby: "nome asc"
          // top: _limit.value,
          // skip: _skip.value,
          );

      final _response = await request.listPatientDatasource(_params, limit: _limit.value, offset: _skip.value);
      if (_response.statusCode != 200) {
        await AppAlert.alertWarning(title: 'Oops!', body: 'Não foi possível listar os dados');
        isLoading.value = AppLoadingStatus.notLoading;
        return;
      }

      // Evita ficar enviando consulta no scroll
      if (_response.model!.length == 0 && listPatient.isNotEmpty) {
        isLoadingPagination.value = true;
        AppAlert.alertSuccess(title: 'Oops!', body: 'Todos os itens já foram listados');
      }

      if (_response.model != null) listPatient.addAll(_response.model!);

      isLoading.value = AppLoadingStatus.notLoading;
      _skip.value = _skip.value + _limit.value;
    } catch (e) {
      AppLog.d('ERROR CONTROLLER PATIENT ===> $e', name: 'getFindPatient');
      isLoading.value = AppLoadingStatus.notLoading;
      isLoadingPagination.value = false;
      AppAlert.alertError(title: 'Oops!', body: 'Não foi possível listar os dados');
    }
  }

  Future<List<PatientModelExt>>? findPatientId(int patientId) async {
    try {
      var _params = QueryParameters(
        select: "id,prontuario,nome,idade,email,dataNascimento,observacoes,fotoBase64",
        expand: "Telefones(\$filter=ativado eq 'S'; \$orderby=data desc; \$count=true)",
        filter: "ativado eq 'S'",
      );
      final _response = await request.findPatientIdDatasource(_params, patientId);
      if (_response.statusCode != 200) {
        AppLog.i('FALHA PESQUISA PATIENT POR ID ${_response.statusCode}', name: 'findPatientId');
        return [];
      }
      if (_response.model != null) return _response.model ?? [];
      return [];
    } catch (e) {
      AppLog.d('ERROR CONTROLLER PESQUISA PATIENT POR ID $e', name: 'findPatientId');
      return [];
    }
  }
}
