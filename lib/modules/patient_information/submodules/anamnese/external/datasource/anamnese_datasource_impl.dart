import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/request_new_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/datasources/anamnese_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/network/response_anamnese_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/network/response_cid_sub_category_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/network/response_ciap_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/network/response_new_anamnese_ext.dart';

class AnamneseDatasourceImpl implements AnamneseDatasource {
  final Network _network;
  AnamneseDatasourceImpl(this._network);

  @override
  Future<ResponseNewAnamneseExt> saveNewAnamneseDatasource(RequestNewAnamnese params, int pacientId) async {
    try {
      final response = await _network.post(AppUrl.savePacienteAnamnese(pacientId), body: params, isAuth: true);
      print("Response $response");
      if (response.statusCode == null) return ResponseNewAnamneseExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
      var _statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var _statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseNewAnamneseExt.fromMap(statusCode: _statusCode, data: null, statusMessage: _statusMessage);
    } catch (e) {
      return ResponseNewAnamneseExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: e.toString());
    }
  }

  @override
  Future<ResponseCiapExt> findCiapDatasource() async {
    try {
      final response = await _network.get(AppUrl.ciap, isAuth: true);
      if (response.statusCode == null) return ResponseCiapExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var _statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var _statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseCiapExt.fromMap(statusCode: _statusCode, data: response.data['value'] ?? [], statusMessage: _statusMessage);
    } catch (e) {
      return ResponseCiapExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: [], statusMessage: e.toString());
    }
  }

  @override
  Future<ResponseCidSubCategoryExt> findCidSubCategoryDatasource() async {
    try {
      final response = await _network.get(AppUrl.cidSubCategoria, isAuth: true);
      if (response.statusCode == null) return ResponseCidSubCategoryExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var _statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var _statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseCidSubCategoryExt.fromMap(statusCode: _statusCode, data: response.data['value'] ?? [], statusMessage: _statusMessage);
    } catch (e) {
      return ResponseCidSubCategoryExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: [], statusMessage: e.toString());
    }
  }

  @override
  Future<ResponseAnamneseExt> findAnamneseDatasource(int pacientId, QueryParameters parameters) async {
    try {
      final response = await _network.get(AppUrl.getPacienteAnamnese(pacientId), isAuth: true, body: parameters);
      if (response.statusCode == null) return ResponseAnamneseExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var _statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var _statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseAnamneseExt.fromMap(statusCode: _statusCode, data: response.data['value'] ?? [], statusMessage: _statusMessage);
    } catch (e) {
      return ResponseAnamneseExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: [], statusMessage: e.toString());
    }
  }

  @override
  Future<ResponseNewAnamneseExt> updateAnamneseDatasource(RequestNewAnamnese params, int pacientId) async {
    try {
      final response = await _network.put(AppUrl.savePacienteAnamnese(pacientId), body: params);
      if (response.statusCode == null) return ResponseNewAnamneseExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
      var _statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var _statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseNewAnamneseExt.fromMap(statusCode: _statusCode, data: null, statusMessage: _statusMessage);
    } catch (e) {
      return ResponseNewAnamneseExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: e.toString());
    }
  }
}
