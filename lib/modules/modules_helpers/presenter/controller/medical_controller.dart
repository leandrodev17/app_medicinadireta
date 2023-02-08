import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/request_delete_principio_ativo.dart';
import 'package:medicinadireta/modules/modules_helpers/external/datasource/medical_datasource_impl.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/widgets/register_principal_active.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/classe_terapeutica.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/forma_farmaceutica.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/medical.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/medical_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/network/response_medical_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/principal_active_ext.dart';

class MedicalController extends GetxController {
  final CheckConnectingNetwork connectingNetwork;
  final MedicalDatasourceImpl request;

  MedicalController(this.connectingNetwork, this.request);

  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  RxList<FormaFarmaceutica> listFormaFarmaceutica = RxList<FormaFarmaceutica>();
  RxList<FormaFarmaceutica> formFormaFarmaceutica = RxList<FormaFarmaceutica>();

  RxList<ClasseTerapeutica> listClasseTerapeutica = RxList<ClasseTerapeutica>();
  RxList<ClasseTerapeutica> formClasseTerapeutica = RxList<ClasseTerapeutica>();

  RxList<PrincipalActiveExt> listRequestPrincipalActive = RxList<PrincipalActiveExt>();

  ///Lista os pricipios ativos do medicamento
  RxList<PrincipalActiveExt> listPrincipalsActives = RxList<PrincipalActiveExt>();

  ///Lista os principios ativos da pesquisa ( pesquisa para vincular um novo principio ativo ao medicamento)
  final RxList<String> listSearchPrincipalActive = RxList<String>();

  RxList<MedicalExt> listMedical = RxList<MedicalExt>();

  final RxBool loadingSave = RxBool(false);
  final RxBool isLoadingSaveNewMedical = RxBool(false);
  final RxBool requiredFields = RxBool(false);
  final RxBool visibilityListMedicalControl = RxBool(false);
  final Rx<AppLoadingStatus> isLoadingSearchFormaFarmaceutica = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);
  final Rx<AppLoadingStatus> isLoadingSearchClasseTerapeutica = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);
  final Rx<AppLoadingStatus> isLoadingSearchPrincipalActive = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);
  final RxBool isSavePrincipalActive = RxBool(false);
  final RxInt newMedicalId = RxInt(0);

  final RxInt activeTab = RxInt(0);

  RxInt deleteItemPrincipioAtivo = RxInt(9999);

  // Quando o campo Uso Contínuo for NÃO, os campos de Quantidade e Forma Farmacêutica se tornam obrigatórios.

  final searchTerapeuticaControllerEC = TextEditingController();
  final searchFarmaceuticaControllerEC = TextEditingController();

  ///pesquisa do principio ativo
  final RxInt valueKeyPrincipalActiveServer = RxInt(DateTime.now().millisecondsSinceEpoch);
  final searchPrincipalActiveServerEC = TextEditingController();

  // chave para os campos de select
  final RxInt valueKeyFormGeneral = RxInt(DateTime.now().millisecondsSinceEpoch);

  // chave forma farmaceutica
  final RxInt valueKeyForma = RxInt(DateTime.now().millisecondsSinceEpoch);

  // chave forma Terapeutica
  final RxInt valueKeyTerapeutica = RxInt(DateTime.now().millisecondsSinceEpoch);

  void setRequiredFields(String? data) {
    requiredFields.value = false;
    if (data != null && data != "S") requiredFields.value = true;
  }

  void setTab(int data) => activeTab.value = data;

  void setClasseTerapeuticaForm(ClasseTerapeutica? data) {
    valueKeyTerapeutica.value = DateTime.now().millisecondsSinceEpoch;
    formClasseTerapeutica.clear();
    if (data != null) {
      formClasseTerapeutica.add(data);
      String? code = "${data.codigo} - ${data.descricao?.toString()}";
      searchTerapeuticaControllerEC.text = code;
      // descriptionAllergyEC.text = data.medDesc?.toString() ?? 'not_value'.tr;
      Get.back();
    }
  }

  Map<String, dynamic>? findItemMap(dynamic data, List<Map<String, dynamic>> dataMap) {
    Map<String, dynamic>? result;
    if (data == null) return result;

    for (Map<String, dynamic> e in dataMap) {
      if (e['id'] == data) result = e;
    }
    return result;
  }

  void setVisibilityMedicalControl(String? data) {
    visibilityListMedicalControl.value = false;
    if (data != null && (data == "PRETA" || data == "VERMELHA SOB RESTRIÇÃO")) visibilityListMedicalControl.value = true;
  }

  void setValuesTextFormFields(Medical data) {
    searchFarmaceuticaControllerEC.text = data.formaFarmaceutica?.toString() ?? '';
    searchTerapeuticaControllerEC.text = data.classeTerapeutica?.toString() ?? '';
    valueKeyTerapeutica.value = DateTime.now().millisecondsSinceEpoch;
    valueKeyForma.value = DateTime.now().millisecondsSinceEpoch;
  }

  void setFormaFarmaceuticaForm(FormaFarmaceutica? data) {
    formFormaFarmaceutica.clear();
    if (data != null) {
      formFormaFarmaceutica.add(data);
      String? code = data.descricao?.toString() ?? '';
      searchFarmaceuticaControllerEC.text = code;
      valueKeyForma.value = DateTime.now().millisecondsSinceEpoch;
      Get.back();
    }
  }

  getFirst({isFirst = false}) async {
    if (isFirst) {
      isLoading.value = AppLoadingStatus.shimmerLoading;
    } else {
      isLoading.value = AppLoadingStatus.fullLoading;
    }
    listMedical.clear();
    await _getDataMedical();
  }

  swipeRefresh() async {
    await getFirst(isFirst: true);
  }

  searchMedical(String term) async {
    isLoading.value = AppLoadingStatus.shimmerLoading;
    await 1.delay();
    await _getDataMedical(term: term);
  }

  _getDataMedical({String? term}) async {
    try {
      QueryParameters paramts = QueryParameters(skip: 0, top: 100);
      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        isLoading.value = AppLoadingStatus.notConnecting;
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }

      if (term != null) {
        String filter = "contains(tolower(medDesc), '$term') OR contains(tolower(principioAtivo), '$term')";
        paramts = QueryParameters(skip: 0, top: 100, filter: filter, expand: "PrincipiosAtivos");
      }

      ResponseMedicalExt response = await request.findAllMedicalDatasource(paramts);
      listMedical.clear();
      if (response.model?.isNotEmpty ?? false) {
        List<MedicalExt>? _data = response.model as List<MedicalExt>;
        listMedical.addAll(_data);
      }
      isLoading.value = AppLoadingStatus.notLoading;
    } catch (e, s) {
      isLoading.value = AppLoadingStatus.notLoading;
      AppLog.d("Não foi possível listar os medicamentos, $e", name: "_getDataMedical", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Não foi possível listar os dados $e', seconds: 5);
    }
  }

  Future<void> getDataMedicalId(int medicalId) async => await _getDataMedicalId(medicalId: medicalId);

  Future<void> _getDataMedicalId({int? medicalId}) async {
    try {
      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        isLoading.value = AppLoadingStatus.notConnecting;
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }

      QueryParameters paramts = QueryParameters(expand: "PrincipiosAtivos");

      ResponseMedicalExt response = await request.findMedicalIdDatasource(paramts, medicalId!);
      listPrincipalsActives.clear();
      if (response.model?.isNotEmpty ?? false) {
        List<MedicalExt>? _data = response.model as List<MedicalExt>;
        if (_data.first.principiosAtivos?.isNotEmpty ?? false) {
          List<PrincipalActiveExt>? _principiosAtivos = _data.first.principiosAtivos as List<PrincipalActiveExt>;
          listPrincipalsActives.addAll(_principiosAtivos);
        }
      }
      isLoading.value = AppLoadingStatus.notLoading;
    } catch (e, s) {
      isLoading.value = AppLoadingStatus.notLoading;
      AppLog.d("Não foi possível listar os medicamentos, $e", name: "_getDataMedical", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Não foi possível listar os dados $e', seconds: 5);
    }
  }

  saveNewMedical(MedicalExt dataRequest) async => await _saveNewMedical(dataRequest);

  _saveNewMedical(MedicalExt dataRequest) async {
    print("xxxxxxxx novo medicamento xxxxxx");
    try {
      loadingSave.value = true;

      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        loadingSave.value = false;
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }

      final resp = await request.registerMedicalDatasource(dataRequest);
      bool status = resp.statusCode == 200;

      if (!status) {
        loadingSave.value = false;
        await AppAlert.alertError(title: "Oops!", body: 'Problema para salvar os dados ${resp.statusMessage}', seconds: 5);
        return;
      }
      await AppAlert.alertSuccess(title: "Sucesso!", body: 'Medicamento incluído com sucesso. \nAgora inclua o Princípio Ativo deste medicamento.', seconds: 5);
      loadingSave.value = false;

      newMedicalId.value = 0;
      if (resp.dataNewMedical != null) {
        // Map<String, dynamic> mapFrom = Map.from(jsonDecode(resp.dataNewMedical.toString()));
        Medical medical = MedicalExt.fromMap(resp.dataNewMedical);
        newMedicalId.value = medical.id ?? 0;
        setTab(1);

        // await 1.delay();
        // Navigator.push(
        //   Get.context!,
        //   MaterialPageRoute<void>(
        //     builder: (BuildContext context) => SearchPrincipalActive(),
        //     fullscreenDialog: true,
        //   ),
        // );
      }
      loadingSave.value = false;
    } catch (e, s) {
      loadingSave.value = false;
      AppLog.d("Problema para salvar os dados do medicamento $e", name: "_saveNewMedical", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Não foi possível salvar os dados $e', seconds: 5);
    }
  }

  searchFormaFarmaceutica(String term) async => await _searchFormaFarmaceutica(term);
  _searchFormaFarmaceutica(String term) async {
    try {
      isLoadingSearchFormaFarmaceutica.value = AppLoadingStatus.shimmerLoading;

      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        isLoadingSearchFormaFarmaceutica.value = AppLoadingStatus.notConnecting;
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }

      var filter = QueryParameters(filter: "contains(tolower(descricaoPluralHibrido), '$term')");
      final resp = await request.findAllMedicalFarmaceuticaDatasource(filter);
      bool status = resp.statusCode == 200;

      if (!status) {
        isLoadingSearchFormaFarmaceutica.value = AppLoadingStatus.notLoading;
        await AppAlert.alertError(title: "Oops!", body: 'Problema para pesquisar o nome do medicamento ${resp.statusMessage}', seconds: 5);
        return;
      }

      listFormaFarmaceutica.clear();
      if (resp.model != null) listFormaFarmaceutica.addAll(resp.model!);

      isLoadingSearchFormaFarmaceutica.value = AppLoadingStatus.notLoading;
    } catch (e, s) {
      isLoadingSearchFormaFarmaceutica.value = AppLoadingStatus.notLoading;
      AppLog.d("Problema para pesquisar o nome do medicamento $e", name: "_updateAllergy", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Problema para pesquisar o nome do medicamento $e', seconds: 5);
    }
  }

  searchClasseTerapeutica(String term) async => await _searchClasseTerapeutica(term);
  _searchClasseTerapeutica(String term) async {
    try {
      isLoadingSearchClasseTerapeutica.value = AppLoadingStatus.shimmerLoading;

      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        isLoadingSearchClasseTerapeutica.value = AppLoadingStatus.notConnecting;
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }

      var filter = QueryParameters(filter: "contains(tolower(composto), '$term')");
      final resp = await request.findMedicalAllTerapeuticaDatasource(filter);
      bool status = resp.statusCode == 200;

      if (!status) {
        isLoadingSearchClasseTerapeutica.value = AppLoadingStatus.notLoading;
        await AppAlert.alertError(title: "Oops!", body: 'Problema para pesquisar o nome do medicamento ${resp.statusMessage}', seconds: 5);
        return;
      }

      listClasseTerapeutica.clear();
      if (resp.model != null) listClasseTerapeutica.addAll(resp.model!);

      isLoadingSearchClasseTerapeutica.value = AppLoadingStatus.notLoading;
    } catch (e, s) {
      isLoadingSearchClasseTerapeutica.value = AppLoadingStatus.notLoading;
      AppLog.d("Problema para pesquisar o nome do medicamento $e", name: "_updateAllergy", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Problema para pesquisar o nome do medicamento $e', seconds: 5);
    }
  }

  searchPrincipalActive(String term) async => await _searchPrincipalActive(term);
  _searchPrincipalActive(String term) async {
    try {
      isLoadingSearchPrincipalActive.value = AppLoadingStatus.shimmerLoading;
      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        isLoadingSearchPrincipalActive.value = AppLoadingStatus.notConnecting;
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }

      ///Medicamento/PrincipioAtivo?api-version=2.0&$count=true&$filter=contains(chave, 'tetra')
      QueryParameters parameters = QueryParameters(filter: "contains(chave, '$term')", count: true);
      final resp = await request.findPrincipalActiveDatasource(parameters);
      bool status = resp.statusCode == 200;
      if (!status) {
        isLoadingSearchPrincipalActive.value = AppLoadingStatus.notLoading;
        await AppAlert.alertError(title: "Oops!", body: 'Problema para pesquisar o principio ativo ${resp.statusMessage}', seconds: 5);
        return;
      }
      listSearchPrincipalActive.clear();
      if (resp.data != null) {
        resp.data?.forEach((e) => listSearchPrincipalActive.add(e["chave"]));
      }
      isLoadingSearchPrincipalActive.value = AppLoadingStatus.notLoading;
    } catch (e, s) {
      isLoadingSearchPrincipalActive.value = AppLoadingStatus.notLoading;
      AppLog.d("Problema para pesquisar o principio ativo $e", name: "_searchPrincipalActive", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Problema para pesquisar o principio ativo $e', seconds: 5);
    }
  }

  addValuePrincipalActiveFields(String? data) {
    if (data != null) {
      searchPrincipalActiveServerEC.text = data;
      valueKeyPrincipalActiveServer.value = DateTime.now().microsecondsSinceEpoch;
      Get.back();
    }
  }

  savePrincipalActive(PrincipalActiveExt item) async => await _savePrincipalActive(item);
  _savePrincipalActive(PrincipalActiveExt item) async {
    try {
      isSavePrincipalActive.value = true;
      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        isSavePrincipalActive.value = false;
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }
      if (newMedicalId.value == 0) {
        isSavePrincipalActive.value = false;
        await AppAlert.alertError(title: "Oops!", body: "ID do medicamento não localizado!", seconds: 15);
        return;
      }
      final resp = await request.registerMedicalPrincipalActiveDatasource(item, newMedicalId.value);
      bool status = resp.statusCode == 200;
      if (!status) {
        isSavePrincipalActive.value = false;
        await AppAlert.alertError(title: "Oops!", body: 'Problema para atribuir o principio ativo ${resp.statusMessage}', seconds: 5);
        return;
      }
      searchPrincipalActiveServerEC.clear();
      valueKeyPrincipalActiveServer.value = DateTime.now().microsecondsSinceEpoch;
      await getDataMedicalId(newMedicalId.value);
      isSavePrincipalActive.value = false;
      await AppAlert.alertSuccess(title: "Sucesso!", body: 'Atribuíção com sucesso!', seconds: 5);
      // removeItemRequestPrincipalActive(item);
    } catch (e, s) {
      isSavePrincipalActive.value = false;
      AppLog.d("Problema para pesquisar o principio ativo $e", name: "searchPrincipalActive", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Problema para pesquisar o principio ativo $e', seconds: 5);
    }
  }

  updateMedical(MedicalExt dataRequest, int medicalId) async => await _updateMedical(dataRequest, medicalId);

  _updateMedical(MedicalExt dataRequest, int medicalId) async {
    try {
      loadingSave.value = true;

      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        loadingSave.value = false;
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }

      final resp = await request.updateMedicalDatasource(dataRequest, medicalId);
      bool status = resp.statusCode == 204;

      if (!status) {
        loadingSave.value = false;
        await AppAlert.alertError(title: "Oops!", body: 'Problema para atualizar os dados ${resp.statusMessage}', seconds: 5);
        return;
      }
      await AppAlert.alertSuccess(title: "Sucesso!", body: 'Medicamento atualizado', seconds: 5);
      loadingSave.value = false;
      setTab(1);
    } catch (e, s) {
      loadingSave.value = false;
      AppLog.d("Problema para atualizar os dados do medicamento $e", name: "_updateMedical", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Não foi possível atualizar os dados $e', seconds: 5);
    }
  }

  deletePrincipiosAtivos(int idPrincipioAtivo, int medicalId, int index) async {
    deleteItemPrincipioAtivo.value = index;
    List<Map<String, dynamic>> _values = [
      {"id": idPrincipioAtivo}
    ];
    await _deletePrincipiosAtivos(_values, medicalId, index);
  }

  _deletePrincipiosAtivos(List<Map<String, dynamic>>? valuesIds, int medicalId, int index) async {
    try {
      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        deleteItemPrincipioAtivo.value = 9999;
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }
      var _req = RequestDeletePrincipioAtivo(idsPrincipiosAtivos: valuesIds);

      final resp = await request.deletePrincipioAtivoDatasource(_req, medicalId);
      bool status = resp.statusCode == 204;

      if (!status) {
        deleteItemPrincipioAtivo.value = 9999;
        await AppAlert.alertError(title: "Oops!", body: 'Falha ao remover principio ativo  ${resp.statusMessage}', seconds: 5);
        return;
      }
      await AppAlert.alertSuccess(title: "Sucesso!", body: 'Principio ativo removido', seconds: 5);
      deleteItemPrincipioAtivo.value = 9999;
      listPrincipalsActives.removeAt(index);
      // Get.back(closeOverlays: true);
    } catch (e, s) {
      deleteItemPrincipioAtivo.value = 9999;
      AppLog.d("Falha ao remover principio ativo $e", name: "_deletePrincipioAtivo", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Falha ao remover principio ativo $e', seconds: 5);
    }
  }
}
