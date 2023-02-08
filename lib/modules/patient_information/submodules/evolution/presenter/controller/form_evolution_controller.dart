import 'dart:convert';

import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/models/request/headers.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/request_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/patient_products_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/external/datasource/evolution_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/patient_products_model_new_evolution_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/presenter/controller/evolution_controller.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:get/get.dart';

import 'package:medicinadireta/core/shared/shared_preferences.dart';

class FormEvolutionController extends GetxController {
  final EvolutionDatasourceImpl request;
  final SharedPreferencesHelper shared;
  final EvolutionController evolutionController;

  FormEvolutionController({required this.request, required this.shared, required this.evolutionController});

  RxList<PatientProductsNewEvolution> productsMap = RxList.empty();
  RxList<PatientProductsModelNewEvolutionExt> productsModelMap = RxList.empty();

  final RxBool loadingSaving = RxBool(false);

  final RxString dataHtml = RxString('');

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  final RxString initialTextHTML = RxString('');
  final RxInt keyRunnerEditor = RxInt(DateTime.now().millisecondsSinceEpoch);

  final RxBool tipoEvolucao = RxBool(false);

  isTipoEvolucao() async {
    String? _dataUser = await SharedPreferencesHelper().getDataCurrentAccess;
    if (_dataUser != null && _dataUser != ConstStrings.appValueNull) {
      var _decode = jsonDecode(_dataUser);
      tipoEvolucao.value = _decode['tipoEvolucao'] == 2;
    }
  }

  String labelPatientProducts(PatientProductsNewEvolution _model) {
    var _nome = _model.servico?.nome;
    var _sequencia = _model.orcamento?.sequencia;
    var _quantidade = _model.quantidade;
    return "$_nome  $_sequencia | $_quantidade";
  }

  getPatientProducts(int pacienteId) async {
    productsMap.clear();
    await _getPatientProducts(pacienteId);
  }

  _getPatientProducts(int pacienteId) async {
    try {
      final String _filter = "(profissionalId eq null or profissionalId eq 0) and Orcamento/statusId ne 3";
      final String _select = "id,orcamento,servico,quantidade";

      var _params = QueryParameters(filter: _filter, select: _select, expand: "Servico,Orcamento");
      var _head = Headers(pacienteId: pacienteId);

      final _response = await request.patientProductsDatasource(_params, _head);
      if (_response.model.isNotEmpty) productsMap.addAll(_response.model);
    } catch (e) {
      AppLog.d('Não foi possível listar produtos para uma nova evolução $e', name: '_getPatientProducts');
    }
  }

  getPatientProductsModel() async {
    productsModelMap.clear();
    await _getPatientProductsModel();
  }

  _getPatientProductsModel() async {
    try {
      final _response = await request.patientProductsModelDatasource();
      if (_response.model.isNotEmpty) productsModelMap.addAll(_response.model);
    } catch (e) {
      AppLog.d('Não foi possível listar modelo de produtos para uma nova evolução $e', name: '_getPatientProductsModel');
    }
  }

  saveNewEvolution(ParamsToNavigationPage params, RequestNewEvolution requestForm) async {
    await _saveNewEvolution(params, requestForm);
  }

  // TODO criar um padrão para exibir somente de erros se não for 401.
  // save
  // patientDetails uma solucao temporaria, o ideal é usar o retorno do cadasto e inserir um novo objeto na lista de evolucoes
  _saveNewEvolution(ParamsToNavigationPage params, RequestNewEvolution requestForm) async {
    try {
      loadingSaving.value = true;
      await 1.delay();
      // TODO tirar essa dúvida com o Felipe
      // historico = recebe o textArea
      // tuss = recebe o id do plano
      // tussDescricao = recebe a descriçao do plano
      // Não bloquear se não existir o  tuss e tussDescricao
      var _params = RequestNewEvolution(historico: requestForm.historico, tuss: requestForm.tuss, tussDescricao: requestForm.tussDescricao);
      final _response = await request.saveNewEvolutionDatasource(_params, params.pacienteId!);

      if (_response.statusCode != 201) {
        loadingSaving.value = false;
        var _msg = 'Não foi possível cadastrar a nova evolução';
        var _jsonEncode = jsonEncode(_response.responseData.toString());
        var _isWarning = _jsonEncode.contains('value');
        // AppLog.w('_jsonEncode $_jsonEncode _isWarning: $_isWarning ');

        if (_isWarning) {
          // AppLog.w('_jsonDecode ${_response.responseData['value']}');
          _msg = _response.responseData['value'];
        }

        AppAlert.alertWarning(title: 'Ops!', body: _msg, seconds: 10);
        return;
      }

      if (_response.statusCode == 201) {
        AppAlert.alertSuccess(title: 'Sucesso!', body: 'Solicitação enviada com sucesso.');
        await 1.delay();
        loadingSaving.value = false;
        Get.back();
        await Get.toNamed(Routes.EVOLUTION, arguments: params);
      }
      loadingSaving.value = false;
    } catch (e) {
      loadingSaving.value = false;
      AppLog.d('Não foi possível salvar a nova evolução $e', name: '_saveNewEvolution');
    }
  }

  //update

  updateNewEvolution({
    required int evolutionId,
    String? localAgenda,
    required ParamsToNavigationPage params,
    required RequestNewEvolution requestForm,
  }) async =>
      await _updateNewEvolution(evolutionId, localAgenda, params, requestForm);

  _updateNewEvolution(int evolutionId, String? localAgenda, ParamsToNavigationPage params, RequestNewEvolution requestForm) async {
    // _modelPatient  = somente para enviar os dados para pag de detalhes do paciente, assim popula o card
    try {
      loadingSaving.value = true;
      await 1.delay();
      var _params = RequestNewEvolution(historico: requestForm.historico, titulo: localAgenda);
      final _response = await request.updateNewEvolutionDatasource(_params, evolutionId);
      if (_response.statusCode != 204) {
        loadingSaving.value = false;
        AppAlert.alertWarning(title: 'Ops!', body: 'Não foi possível atualizar a evolução');
        return;
      }
      // lista mensagem para 400,401..
      // AppAlert.alertAll(statusCode: _response.statusCode!);

      if (_response.statusCode == 204) {
        AppAlert.alertSuccess(title: 'Sucesso!', body: 'Atualização realizada com sucesso');
        // var _index = evolutionController.listEvolution.indexOf(_modelEvolution);
        // EvolutionExt _modelNew = _updateModelListEvolution(_modelEvolution);
        // evolutionController.listEvolution.removeAt(_index);
        // evolutionController.listEvolution.insert(_index, _modelNew);
        await 1.delay();
        // Get.back(closeOverlays: true);
        loadingSaving.value = false;
        await Get.toNamed(Routes.EVOLUTION, arguments: params);
      }
    } catch (e) {
      loadingSaving.value = false;
      AppLog.d('Não foi possível editar a evolução $e', name: '_saveNewEvolution');
    }
  }
}
