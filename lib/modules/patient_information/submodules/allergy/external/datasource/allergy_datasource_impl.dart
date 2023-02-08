import 'dart:convert';

import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/datasources/allergy_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/network/request_allergy_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/network/response_allergy_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/network/response_medical_ext.dart';

class AllergyDatasourceImpl implements AllergyDatasource {
  final Network _network;
  AllergyDatasourceImpl(this._network);

  @override
  Future<ResponseAllergyExt> findAllergysDatasource(int pacientId, QueryParameters parameters) async {
    try {
      final response = await _network.get(AppUrl.getPacienteAlergia(pacientId), isAuth: true, body: parameters);
      if (response.statusCode == null) return ResponseAllergyExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseAllergyExt.fromMap(statusCode: statusCode, data: response.data['value'] ?? [], statusMessage: statusMessage);
    } catch (e) {
      return ResponseAllergyExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }

  @override
  Future<ResponseAllergyExt> saveAllergysDatasource(int pacientId, RequestAllergyExt parameters) async {
    try {
      final response = await _network.post(AppUrl.postPacienteAlergia(pacientId), isAuth: true, body: parameters);
      if (response.statusCode == null) return ResponseAllergyExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      if (response.statusCode != 201) {
        String _encode = jsonEncode(response.data.toString());
        if (_encode.contains("value")) {
          var _decode = response.data;
          statusMessage = _decode["value"];
        }
      }
      return ResponseAllergyExt.fromMap(statusCode: statusCode, data: const [], statusMessage: statusMessage);
    } catch (e) {
      return ResponseAllergyExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }

  @override
  Future<ResponseAllergyExt> updateAllergysDatasource(int allergyId, RequestAllergyExt parameters) async {
    try {
      final response = await _network.put(AppUrl.putPacienteAlergia(allergyId), body: parameters);
      AppLog.i("response $response");
      if (response.statusCode == null) return ResponseAllergyExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;

      if (response.statusCode != 204) {
        String _encode = jsonEncode(response.data.toString());
        if (_encode.contains("value")) {
          var _decode = response.data;
          statusMessage = _decode["value"];
        }
      }
      return ResponseAllergyExt.fromMap(statusCode: statusCode, data: const [], statusMessage: statusMessage);
    } catch (e) {
      return ResponseAllergyExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
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
  Future<ResponseMedicalExt> findOneMedicalDatasource(QueryParameters? parameters, int medicalId) async {
    try {
      final response = await _network.get(AppUrl.findOneMedical(medicalId), body: parameters);
      AppLog.i("$response", name: 'findOneMedicalDatasource');
      if (response.statusCode == null) return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseMedicalExt.fromMap(statusCode: statusCode, data: const [], statusMessage: statusMessage);
    } catch (e) {
      return ResponseMedicalExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }

}
