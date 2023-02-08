import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/modules/patient/infra/datasources/patient_datasource.dart';
import 'package:medicinadireta/modules/patient/infra/models/network/response_patient_ext.dart';

class PatientDatasourceImpl implements PatientDatasource {
  final Network _network;
  PatientDatasourceImpl(this._network);

  @override
  Future<ResponsePatientExt> listPatientDatasource(QueryParameters parameters, {int limit = 20, int offset = 0, int id = 0, String nome = "''", String cpf = "''"}) async {
    try {
      final response = await _network.get(AppUrl.refactoryListPatient(limit: limit, offset: offset, id: id, nome: nome, cpf: cpf), body: parameters);
      if (response.statusCode == null) return ResponsePatientExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
      var statusMessage = response.statusMessage;
      var statusCode = response.statusCode;
      return ResponsePatientExt.fromMap(statusCode: statusCode, data: response.data['value'], statusMessage: statusMessage);
    } catch (e) {
      return ResponsePatientExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: e.toString());
    }
  }

  @override
  Future<ResponsePatientExt> findPatientDatasource(QueryParameters parameters, {int limit = 20, int offset = 0, int id = 0, String nome = "''", String cpf = "''"}) async {
    try {
      final response = await _network.get(AppUrl.refactoryListPatient(limit: limit, offset: offset, id: id, nome: nome, cpf: cpf), body: parameters);

      if (response.statusCode == null) {
        return ResponsePatientExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
      }
      var statusMessage = response.statusMessage;
      var statusCode = response.statusCode;
      return ResponsePatientExt.fromMap(statusCode: statusCode, data: response.data['value'], statusMessage: statusMessage);
    } catch (e) {
      return ResponsePatientExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: e.toString());
    }
  }

  @override
  Future<ResponsePatientExt> findPatientIdDatasource(QueryParameters parameters, int patientId) async {
    try {
      final response = await _network.get(AppUrl.findPatientId(patientId), body: parameters);
      if (response.statusCode == null) {
        return ResponsePatientExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
      }
      var statusMessage = response.statusMessage;
      var statusCode = response.statusCode;
      var data = response.data != null ? [response.data] : [];
      return ResponsePatientExt.fromMap(statusCode: statusCode, data: data, statusMessage: statusMessage);
    } catch (e) {
      return ResponsePatientExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: e.toString());
    }
  }
}
