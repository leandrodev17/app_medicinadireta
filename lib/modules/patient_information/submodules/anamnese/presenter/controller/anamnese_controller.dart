import 'dart:convert';

import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/request_new_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/external/datasource/anamnese_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/anamnese_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/ciap_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/cid_sub_category_ext.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:get/get.dart';

class AnamneseController extends GetxController {
  final AnamneseDatasourceImpl request;
  final CheckConnectingNetwork connectingNetwork;

  AnamneseController({required this.connectingNetwork, required this.request});

  RxList<AnamneseExt> listItensAnamnese = RxList<AnamneseExt>();
  RxList<CidSubCategoriaExt> listItensCidSubCategory = RxList<CidSubCategoriaExt>();
  RxList<CiapExt> listItensCiap = RxList<CiapExt>();
  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);
  final RxInt storageUserId = RxInt(0);
  final RxList<String> listOptions = RxList<String>(['--', 'CIAP2', 'CID-10']);
  final RxString itemOption = RxString('--');

  final RxBool loadingSaving = RxBool(false);

  @override
  void onInit() async {
    itemOption.value = '--';
    await loadInfoUserStorage();
    super.onInit();
  }

  /// Bloco para selecionar item para preencher dados para request
  changeOptions(String? op) {
    try {
      if (op == null) return;
      if (op == '--') {
        itemOption.value = '--';
        return;
      }
      itemOption.value = op;
    } catch (e) {
      AppLog.d("Não foi possível alterar o estado da variável $e", name: "changeStateVisibleFields");
    }
  }

  /// LISTA PARA CONTROLAR QUAIS CAMPOS DEVEM SER EXIBIDOS PARA O CADASTRO
  RxList<Map<String, dynamic>> fieldsForm = RxList<Map<String, dynamic>>([
    {"id": "1", "value": "HDA - Hist. da Doença Atual", "visible": true},
    {"id": "2", "value": "HPP - Hist. das Patologias Pregressas", "visible": true},
    {"id": "3", "value": "Hábitos e Estilo de Vida", "visible": true},
    {"id": "4", "value": "Drogas/Tabagismo/Álcool", "visible": true},
    {"id": "5", "value": "Histórico Mental e Social", "visible": true},
    {"id": "6", "value": "Histórico Familiar", "visible": true},
    {"id": "7", "value": "Outros", "visible": true},
  ]);

  /// Manipula o valor boleano para exibir ou nao o campo
  changeStateVisibleFields(int index) {
    try {
      var _data = fieldsForm[index];
      Map<String, dynamic> _map = {"id": _data['id'], "value": _data['value'], "visible": !_data['visible']};
      fieldsForm.removeAt(index);
      fieldsForm.insert(index, _map);
    } catch (e) {
      AppLog.d("Não foi possível alterar o estado da variável $e", name: "changeStateVisibleFields");
    }
  }

  getFirst({isFirst = false, int? pacientId}) async {
    if (isFirst) {
      isLoading.value = AppLoadingStatus.shimmerLoading;
    } else {
      isLoading.value = AppLoadingStatus.fullLoading;
    }
    listItensAnamnese.clear();
    if (pacientId != null) await _getDataAnamnese(pacientId);
  }

  swipeRefresh({int? pacientId}) async {
    if (pacientId != null) await getFirst(isFirst: true, pacientId: pacientId);
  }

  loadInfoUserStorage() async {
    String? _data = await SharedPreferencesHelper().getDataCurrentAccess;
    if (_data != null && _data != ConstStrings.appValueNull) {
      var _user = jsonDecode(_data);
      storageUserId.value = _user["id"];
    }
  }

  bool isEditAnamnese({int? userId, String? edit}) {
    try {
      if (userId == null || edit == null) return false;
      if (storageUserId.value != 0 && edit == "S" && userId == storageUserId.value) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  String dateFormatAnamnese(String? dataLocal) {
    try {
      if (dataLocal == null) return "--";
      DateTime _dateTime = DateTime.parse(dataLocal.toString());
      String _formatDate = FormatsDatetime.formatDate(_dateTime, FormatsDatetime.dateHourFormat);
      return _formatDate;
    } catch (e) {
      return "--";
    }
  }

  _getDataAnamnese(int pacientId) async {
    try {
      bool _isConnected = await connectingNetwork.appCheckConnectivity();
      if (!_isConnected) {
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }
      QueryParameters _paramts = const QueryParameters(orderby: "dataEvento desc", expand: "Profissional(\$expand=Conselho)");
      var _response = await request.findAnamneseDatasource(pacientId, _paramts);
      if (_response.model?.isNotEmpty ?? false) listItensAnamnese.addAll(_response.model!);
      isLoading.value = AppLoadingStatus.notLoading;
    } catch (e, s) {
      isLoading.value = AppLoadingStatus.notLoading;
      AppLog.d("Não foi possível listar os registros cadastrados de anamnese, $e", name: "anamneseAll", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Não foi possível listar os dados $e', seconds: 5);
    }
  }

  getDataCidSubCategory() async => await _getDataCidSubCategory();

  _getDataCidSubCategory() async {
    try {
      listItensCidSubCategory.clear();
      bool _isConnected = await connectingNetwork.appCheckConnectivity();
      if (!_isConnected) {
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }
      var _response = await request.findCidSubCategoryDatasource();
      if (_response.model?.isNotEmpty ?? false) listItensCidSubCategory.addAll(_response.model!);
    } catch (e, s) {
      AppLog.d("Não foi possível listar os registros CID SUB-CATEGORIA, $e", name: "_getDataCidSubCategory", stackTrace: s);
    }
  }

  getDataCiap() async => await _getDataCiap();

  _getDataCiap() async {
    try {
      listItensCiap.clear();
      bool _isConnected = await connectingNetwork.appCheckConnectivity();
      if (!_isConnected) {
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }
      var _response = await request.findCiapDatasource();
      if (_response.model?.isNotEmpty ?? false) listItensCiap.addAll(_response.model!);
    } catch (e, s) {
      AppLog.d("Não foi possível listar os registros CIAP, $e", name: "_getDataCiap", stackTrace: s);
    }
  }

  saveAnamnese({required RequestNewAnamnese requestData, int? pacientId, required ParamsToNavigationPage params, bool? edit, int? anamneseId}) async {
    if (pacientId == null) {
      await AppAlert.alertWarning(title: "Atenção!", body: "Problema para identificar o paciente, tente recarregar a tela e refaça o procedimento", seconds: 15);
      return;
    }
    await _saveAnamnese(requestData: requestData, pacientId: pacientId, params: params, edit: edit, anamneseId: anamneseId);
  }

  _saveAnamnese({required RequestNewAnamnese requestData, int? pacientId, required ParamsToNavigationPage params, bool? edit, int? anamneseId}) async {
    try {
      loadingSaving.value = true;
       await 1.delay();
      bool _isConnected = await connectingNetwork.appCheckConnectivity();
      if (!_isConnected) {
        await AppAlert.alertError(title: "Oops!", body: "Problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }
      var _response;
      if (edit != null && edit == true && anamneseId != null) {
        _response = await request.updateAnamneseDatasource(requestData, anamneseId);
      } else {
        _response = await request.saveNewAnamneseDatasource(requestData, pacientId!);
      }

      if (_response.statusCode != 201 && _response.statusCode != 204) {
        loadingSaving.value = false;
        await AppAlert.alertWarning(title: "Atenção!", body: "Não foi possível salvar os dados da requisição ${_response.statusCode}", seconds: 15);
        return;
      }
      await AppAlert.alertSuccess(title: "Sucesso!", body: "Anamnese cadastrado com sucesso", seconds: 15);
      await 1.delay();
      loadingSaving.value = false;
      await Get.toNamed(Routes.ANAMNESE, arguments: params);
    } catch (e, s) {
      loadingSaving.value = false;
      AppLog.d("Não foi possível listar os registros CIAP, $e", name: "_saveAnamnese", stackTrace: s);
      await AppAlert.alertError(title: "Falha!", body: "Não foi possível salva os dados $e", seconds: 15);
    }
  }
}
