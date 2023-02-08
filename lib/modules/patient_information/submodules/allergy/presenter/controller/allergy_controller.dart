import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/medical.dart';
import 'package:medicinadireta/routes/app_pages.dart';

import '../../infra/models/network/request_allergy_ext.dart';

import '/constants/const_strings.dart';
import '/core/alert/app_alert.dart';
import '/core/enum/app_loading_status.dart';
import '/core/helpers/formats_datetime.dart';
import '/core/models/request/query_parameters.dart';
import '/core/network/check_connecting_network.dart';
import '/core/shared/shared_preferences.dart';
import '/core/widgets/app_log.dart';
import '/modules/patient_information/submodules/allergy/domain/entities/allergy.dart';
import '/modules/patient_information/submodules/allergy/external/datasource/allergy_datasource_impl.dart';

class AllergyController extends GetxController {
  final AllergyDatasourceImpl request;
  final CheckConnectingNetwork connectingNetwork;
  final SharedPreferencesHelper sharedPreferencesHelper;

  AllergyController({required this.connectingNetwork, required this.request, required this.sharedPreferencesHelper});

  RxList<Allergy> listItensAllergys = RxList<Allergy>();

  RxList<Medical> listMedical = RxList<Medical>();
  RxList<Medical> medicalForm = RxList<Medical>();
  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);
  final Rx<AppLoadingStatus> isLoadingSearchMedical = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  final RxInt storageUserId = RxInt(0);
  final RxInt isExpandedIndex = RxInt(9999);
  final RxInt valueKeySelected = RxInt(DateTime.now().millisecondsSinceEpoch);
  final RxBool visibilityMedical = RxBool(false);

  final RxBool visibilityDateOcorrido = RxBool(false);
  final RxBool loadingSave = RxBool(false);
  final RxBool isLoadingSaveNewMedical = RxBool(false);
  final RxBool loadingFindMedical = RxBool(false);

  final searchControllerEC = TextEditingController();
  final descriptionAllergyEC = TextEditingController();

  RxMap<String, dynamic> selectedItemUTC = RxMap<String, dynamic>({"id": "-03:00", "value": "-03:00"});

  @override
  void onInit() {
    visibilityMedical.value = false;
    visibilityDateOcorrido.value = false;
    super.onInit();
  }

  void loadingUTC() async {
    selectedItemUTC.clear();
    String utc = '-03:00';
    String? data = await SharedPreferencesHelper().getDataCurrentAccess;
    if (data != null && data != ConstStrings.appValueNull) {
      var user = jsonDecode(data);
      utc = user["id"];
      var _map = findItemMap(utc.toString(), ConstStrings.listUTC);
      if (_map != null) {
        selectedItemUTC.addAll(_map);
      }
    }
  }

  void setMedicalSendForm(Medical? data) {
    medicalForm.clear();
    if (data != null) {
      medicalForm.add(data);
      String _principioAtivo = data.principioAtivo?.toString() ?? '';
      String _medDesc = data.medDesc?.toString() ?? '';
      String medDesc = "$_medDesc - $_principioAtivo";

      searchControllerEC.text = data.medDesc?.toString() ?? 'not_value'.tr;
      descriptionAllergyEC.text = medDesc;
      Get.back();
    }
  }

  void setVisibilityMedical(int? data) {
    visibilityMedical.value = false;
    searchControllerEC.clear();
    descriptionAllergyEC.clear();
    medicalForm.clear();
    if (data != null && (data == 11 || data == 5)) visibilityMedical.value = true;
  }

  void setVisibilityOcorrido(String? data) {
    visibilityDateOcorrido.value = false;
    if (data != null && data != "N") visibilityDateOcorrido.value = true;
  }

  Map<String, dynamic>? findItemMap(dynamic data, List<Map<String, dynamic>> dataMap) {
    Map<String, dynamic>? result;
    if (data == null) return result;

    for (Map<String, dynamic> e in dataMap) {
      if (e['id'] == data) result = e;
    }
    return result;
  }

  DateTime prepareDateTime(String? data) {
    DateTime result = DateTime.now();
    if (data == null || data == '') return result;
    result = DateTime.parse(data);
    return result;
    // _dateOcorridoDeEC.text = FormatsDatetime.formatDate(date, FormatsDatetime.dateHourFormat);
    // _initialDateOcorridoAte = date;
  }

  String formatsDateTime(String? data, {bool time = false}) {
    String result = '';
    if (data == null || data == '') return result;
    result = FormatsDatetime.formatDate(prepareDateTime(data), time ? FormatsDatetime.dateHourFormat : FormatsDatetime.dateFormat);
    return result;
  }

  void Function(int, bool)? expansionCallback(int index, bool isExpanded) {
    if (isExpanded) {
      isExpandedIndex.value = 9999;
    } else {
      isExpandedIndex.value = index;
    }
    return null;
  }

  bool isEditAllergys({int? userId, String? edit}) {
    try {
      if (userId == null || edit == null) return false;
      if (storageUserId.value != 0 && edit == "S" && userId == storageUserId.value) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  String dateFormatAllergy(String? dataLocal) {
    try {
      if (dataLocal == null) return "--";
      DateTime dateTime = DateTime.parse(dataLocal.toString());
      String formatDate = FormatsDatetime.formatDate(dateTime, FormatsDatetime.dateHourFormat);
      return formatDate;
    } catch (e) {
      return "--";
    }
  }

  loadInfoUserStorage() async {
    String? data = await sharedPreferencesHelper.getDataCurrentAccess;
    if (data != null && data != ConstStrings.appValueNull) {
      var user = jsonDecode(data);
      storageUserId.value = user["id"];
    }
  }

  getFirst({isFirst = false, int? pacientId}) async {
    if (isFirst) {
      isLoading.value = AppLoadingStatus.shimmerLoading;
    } else {
      isLoading.value = AppLoadingStatus.fullLoading;
    }
    listItensAllergys.clear();
    if (pacientId != null) await _getDataAllergy(pacientId);
  }

  swipeRefresh({int? pacientId}) async {
    if (pacientId != null) await getFirst(isFirst: true, pacientId: pacientId);
  }

  _getDataAllergy(int pacientId) async {
    try {
      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }
      QueryParameters paramts = const QueryParameters(orderby: "dataEvento desc", expand: "Profissional(\$expand=Conselho)");
      var response = await request.findAllergysDatasource(pacientId, paramts);
      if (response.model?.isNotEmpty ?? false) listItensAllergys.addAll(response.model!);
      isLoading.value = AppLoadingStatus.notLoading;
    } catch (e, s) {
      isLoading.value = AppLoadingStatus.notLoading;
      AppLog.d("Não foi possível listar os registros cadastrados de alergia, $e", name: "_getDataAllergy", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Não foi possível listar os dados $e', seconds: 5);
    }
  }

  saveAllergy(RequestAllergyExt dataRequest, ParamsToNavigationPage paramsToNavigationPage) async => await _saveAllergy(dataRequest, paramsToNavigationPage);

  _saveAllergy(RequestAllergyExt dataRequest, ParamsToNavigationPage paramsToNavigationPage) async {
    try {
      loadingSave.value = true;

      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        loadingSave.value = false;
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }

      final resp = await request.saveAllergysDatasource(paramsToNavigationPage.pacienteId!, dataRequest);
      bool status = resp.statusCode == 201;

      if (!status) {
        loadingSave.value = false;
        await AppAlert.alertError(title: "Oops!", body: 'Problema para salvar os dados ${resp.statusMessage}', seconds: 5);
        return;
      }
      await AppAlert.alertSuccess(title: "Sucesso!", body: 'Cadastro com sucesso', seconds: 5);
      loadingSave.value = false;
      await 1.delay();
      await Get.toNamed(Routes.ALLERGYS, arguments: paramsToNavigationPage);
    } catch (e, s) {
      loadingSave.value = false;
      AppLog.d("Problema para salvar os dados da alergia $e", name: "_saveAllergy", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Não foi possível salvar os dados $e', seconds: 5);
    }
  }

  updateAllergy(RequestAllergyExt dataRequest, ParamsToNavigationPage paramsToNavigationPage, int allergyId) async =>
      await _updateAllergy(dataRequest, paramsToNavigationPage, allergyId);

  _updateAllergy(RequestAllergyExt dataRequest, ParamsToNavigationPage paramsToNavigationPage, int allergyId) async {
    try {
      loadingSave.value = true;

      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        loadingSave.value = false;
        await AppAlert.alertError(title: "Oops!", body: "Problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }
      // dataRequest = dataRequest.copyWith(editavel: "N");
      final resp = await request.updateAllergysDatasource(allergyId, dataRequest);
      bool status = resp.statusCode == 204;

      if (!status) {
        loadingSave.value = false;
        await AppAlert.alertError(title: "Oops!", body: resp.statusMessage ?? 'Problema para atualizar os dados', seconds: 5);
        return;
      }
      await AppAlert.alertSuccess(title: "Sucesso!", body: 'Dados atualizado', seconds: 5);
      loadingSave.value = false;
      await 1.delay();
      await Get.toNamed(Routes.ALLERGYS, arguments: paramsToNavigationPage);
    } catch (e, s) {
      loadingSave.value = false;
      AppLog.d("Problema para salvar os dados da alergia", name: "_updateAllergy", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Não foi possível atualizar os dados $e', seconds: 5);
    }
  }

  searchMedical(String term) async => await _searchMedical(term);
  _searchMedical(String term) async {
    try {
      isLoadingSearchMedical.value = AppLoadingStatus.shimmerLoading;

      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        isLoadingSearchMedical.value = AppLoadingStatus.notConnecting;
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }

      var filter = QueryParameters(filter: "contains(tolower(medDesc), '$term')");
      final resp = await request.findAllMedicalDatasource(filter);
      bool status = resp.statusCode == 200;

      if (!status) {
        isLoadingSearchMedical.value = AppLoadingStatus.notLoading;
        await AppAlert.alertError(title: "Oops!", body: 'Problema para pesquisar o nome do medicamento ${resp.statusMessage}', seconds: 5);
        return;
      }

      listMedical.clear();
      if (resp.model != null) listMedical.addAll(resp.model!);

      isLoadingSearchMedical.value = AppLoadingStatus.notLoading;
    } catch (e, s) {
      isLoadingSearchMedical.value = AppLoadingStatus.notLoading;
      AppLog.d("Problema para pesquisar o nome do medicamento $e", name: "_updateAllergy", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Problema para pesquisar o nome do medicamento $e', seconds: 5);
    }
  }
}
