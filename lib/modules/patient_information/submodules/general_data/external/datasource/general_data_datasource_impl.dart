import 'dart:convert';

import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/params_general_data.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/infra/datasources/general_data_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/infra/models/network/response_general_data_ext.dart';

class GeneralDataDatasourceImpl implements GeneralDataDatasource {
  final Network _network;
  GeneralDataDatasourceImpl(this._network);

  @override
  Future<ResponseGeneralDataExt> findGeneralDataDatasource(int patientId, QueryParameters queryParameters) async {
    try {
      final response = await _network.get(AppUrl.findPatient(patientId), body: queryParameters);
      if (response.statusCode == null) return ResponseGeneralDataExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);

      dynamic _data;
      dynamic statusMessage;

      if (response.data != null) {
        if (response.statusCode != 200) {
          String _encode = jsonEncode(response.data.toString());
          if (_encode.contains("value")) {
            statusMessage = response.data["value"];
          }
          _data = null;
        } else {
          _data = response.data;
        }
      }

      return ResponseGeneralDataExt.fromMap(statusCode: response.statusCode, statusMessage: statusMessage, data: _data);
    } on Exception catch (e, s) {
      AppLog.d("Problema para pesquisar $e", stackTrace: s, name: 'findGeneralDataDatasource');
      return ResponseGeneralDataExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
    }
  }

  @override
  Future<ResponseGeneralDataExt> saveGeneralDataDatasource(ParamsGeneralData req, int patientId) async {
    try {
      final response = await _network.put(AppUrl.findPatient(patientId), body: req);
      if (response.statusCode == null) return ResponseGeneralDataExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
      dynamic _data;
      dynamic statusMessage;

      if (response.data != null) {
        if (response.statusCode != 200) {
          String encode = jsonEncode(response.data.toString());
          if (encode.contains("value")) {
            statusMessage = response.data["value"];
          }
          _data = null;
        } else {
          _data = response.data;
        }
      }
      return ResponseGeneralDataExt.fromMap(statusCode: response.statusCode, statusMessage: statusMessage, data: _data);
    } on Exception catch (e, s) {
      AppLog.d("Problema para salvar o paciente dados gerais $e", stackTrace: s, name: 'saveGeneralDataDatasource');
      return ResponseGeneralDataExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
    }
  }
}
