import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/request_delete_principio_ativo.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/datasources/medical_datasource.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/network/response_principal_active.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/medical_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/network/response_classe_terapeutica_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/network/response_forma_farmaceutica_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/network/response_medical_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/principal_active_ext.dart';

class MedicalDatasourceImpl implements MedicalDatasource {
  final Network _network;
  MedicalDatasourceImpl(this._network);

  @override
  Future<ResponseMedicalExt> registerMedicalDatasource(MedicalExt request) async {
    try {
      final response = await _network.post(AppUrl.registerMedical, body: request, isAuth: true);
      if (response.statusCode == null) {
        return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT, dataNewMedical: null);
      }
      var statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseMedicalExt.fromMap(statusCode: statusCode, data: const [], statusMessage: statusMessage, dataNewMedical: response.data);
    } catch (e) {
      return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString(), dataNewMedical: null);
    }
  }

  @override
  Future<ResponseMedicalExt> registerMedicalPrincipalActiveDatasource(PrincipalActiveExt request, int medicalId) async {
    try {
      final response = await _network.post(AppUrl.registerMedicalPrincipalActive(medicalId), body: request, isAuth: true);
      if (response.statusCode == null) return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseMedicalExt.fromMap(statusCode: statusCode, data: const [], statusMessage: statusMessage);
    } catch (e) {
      return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }

  @override
  Future<ResponseFormaFarmaceuticaExt> findAllMedicalFarmaceuticaDatasource(QueryParameters? parameters) async {
    try {
      final response = await _network.get(AppUrl.findAllMedicalFarmaceutica, body: parameters);
      if (response.statusCode == null) return ResponseFormaFarmaceuticaExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseFormaFarmaceuticaExt.fromMap(statusCode: statusCode, data: response.data['value'] ?? [], statusMessage: statusMessage);
    } catch (e) {
      return ResponseFormaFarmaceuticaExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }

  @override
  Future<ResponseClasseTerapeuticaExt> findMedicalAllTerapeuticaDatasource(QueryParameters? parameters) async {
    try {
      final response = await _network.get(AppUrl.findAllMedicalTerapeutica, body: parameters);
      if (response.statusCode == null) return ResponseClasseTerapeuticaExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseClasseTerapeuticaExt.fromMap(statusCode: statusCode, data: response.data['value'] ?? [], statusMessage: statusMessage);
    } catch (e) {
      return ResponseClasseTerapeuticaExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }

  @override
  Future<ResponsePrincipalActive> findPrincipalActiveDatasource(QueryParameters parameters) async {
    try {
      final response = await _network.get(AppUrl.findAllMedicalPrincipalActive, body: parameters);
      if (response.statusCode == null) return ResponsePrincipalActive.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponsePrincipalActive.fromMap(statusCode: statusCode, data: response.data["value"], statusMessage: statusMessage);
    } catch (e) {
      return ResponsePrincipalActive.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }

  @override
  Future<ResponseMedicalExt> findAllMedicalDatasource(QueryParameters parameters) async {
    try {
      final response = await _network.get(AppUrl.medical, body: parameters);
      if (response.statusCode == null) return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseMedicalExt.fromMap(statusCode: statusCode, data: response.data['value'] ?? [], statusMessage: statusMessage);
    } catch (e) {
      return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }

  @override
  Future<ResponseMedicalExt> updateMedicalDatasource(MedicalExt request, int medicalId) async {
    try {
      final response = await _network.put(AppUrl.updateMedical(medicalId), body: request);
      if (response.statusCode == null) {
        return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT, dataNewMedical: null);
      }
      var statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseMedicalExt.fromMap(statusCode: statusCode, data: const [], statusMessage: statusMessage, dataNewMedical: response.data);
    } catch (e) {
      return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString(), dataNewMedical: null);
    }
  }

  @override
  Future<ResponseMedicalExt> findMedicalIdDatasource(QueryParameters parameters, int medicalId) async {
    try {
      final response = await _network.get(AppUrl.findMedicalId(medicalId), body: parameters);
      if (response.statusCode == null) return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      List<dynamic> _data = [response.data];
      return ResponseMedicalExt.fromMap(statusCode: statusCode, data: _data, statusMessage: statusMessage);
    } catch (e) {
      return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }

  @override
  Future<ResponseMedicalExt> deletePrincipioAtivoDatasource(RequestDeletePrincipioAtivo request, int medicalId) async {
    try {
      final response = await _network.delete(AppUrl.deletePrincipiosAtivos(medicalId), body: request);
      if (response.statusCode == null) return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseMedicalExt.fromMap(statusCode: statusCode, data: const [], statusMessage: statusMessage);
    } catch (e) {
      return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }
}


///