import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/models/request/headers.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/params_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/request_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/datasources/evolution_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/network/response_evolution_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/network/response_new_evolution_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/network/response_patient_products_model_new_evolution_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/network/response_patient_products_new_evolution_ext.dart';

class EvolutionDatasourceImpl implements EvolutionDatasource {
  final Network _network;
  EvolutionDatasourceImpl(this._network);

  @override
  Future<ResponseEvolutionExt> evolutionDatasource(ParamsEvolution req, int patientId) async {
    try {
      final response = await _network.get(AppUrl.patientEvolutionGet(patientId), body: req);
      if (response.statusCode == null) return ResponseEvolutionExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);

      var _statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var _statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      var _result = response.data['value'] ?? null;

      return ResponseEvolutionExt.fromMap(statusCode: _statusCode, data: _result, statusMessage: _statusMessage);
      
    } catch (e) {
      AppLog.d('Não foi possível listar os tipos de produtos para o cadastro da evolução $e', name: 'patientProductsDatasource');
      return ResponseEvolutionExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
    }
    // } else {
    //   var _statusMessage = response.statusMessage;
    //   var _statusCode = response.statusCode;
    //   return ResponseEvolutionExt.fromMap(
    //     statusCode: _statusCode,
    //     statusMessage: _statusMessage,
    //     errorMessage: null,
    //     odata: null,
    //     data: [],
    //   );
    // }
  }

  @override
  Future<ResponsePatientProductsNewEvolutionExt> patientProductsDatasource(QueryParameters req, Headers head) async {
    try {
      final response = await _network.get(AppUrl.patientProducts, body: req, headers: head);
      if (response.statusCode == null) return ResponsePatientProductsNewEvolutionExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
      return ResponsePatientProductsNewEvolutionExt.fromMap(statusCode: response.statusCode, statusMessage: response.statusMessage, data: response.data['value']);
    } catch (e) {
      AppLog.d('Não foi possível listar os tipos de produtos para o cadastro da evolução $e', name: 'patientProductsDatasource');
      return ResponsePatientProductsNewEvolutionExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
    }
  }

  @override
  Future<ResponsePatientProductsModelNewEvolutionExt> patientProductsModelDatasource() async {
    try {
      final response = await _network.get(AppUrl.evolutionModel);
      if (response.statusCode == null)
        return ResponsePatientProductsModelNewEvolutionExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
      return ResponsePatientProductsModelNewEvolutionExt.fromMap(statusCode: response.statusCode, statusMessage: response.statusMessage, data: response.data['value']);
    } catch (e) {
      AppLog.d('Não foi possível listar os tipos de modelos para o cadastro da evolução $e', name: 'patientProductsModelDatasource');
      return ResponsePatientProductsModelNewEvolutionExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
    }
  }

  @override
  Future<ResponseNewEvolutionExt> saveNewEvolutionDatasource(RequestNewEvolution req, int patientId) async {
    try {
      final response = await _network.post(AppUrl.patientEvolutionPOST(patientId), body: req, isAuth: true);
      if (response.statusCode == null) return ResponseNewEvolutionExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
      return ResponseNewEvolutionExt.fromMap(statusCode: response.statusCode, data: response.data);
    } catch (e) {
      AppLog.d('Não foi possível salvar a evolução $e', name: 'saveNewEvolutionDatasource');
      return ResponseNewEvolutionExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
    }
  }

  @override
  Future<ResponseNewEvolutionExt> updateNewEvolutionDatasource(RequestNewEvolution req, int evolutionId) async {
    try {
      final response = await _network.put(AppUrl.patientEvolutionPUT(evolutionId), body: req);
      if (response.statusCode == null) return ResponseNewEvolutionExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
      return ResponseNewEvolutionExt.fromMap(statusCode: response.statusCode, data: []);
    } catch (e) {
      AppLog.d('Não foi possível atualizar a evolução $e', name: 'updateNewEvolutionDatasource');
      return ResponseNewEvolutionExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
    }
  }
}
