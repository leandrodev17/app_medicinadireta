import 'dart:convert';

import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/new_patient/domain/entities/network/request_new_patient.dart';
import 'package:medicinadireta/modules/new_patient/infra/datasources/new_patient_datasource.dart';
import 'package:medicinadireta/modules/new_patient/infra/models/network/response_new_patient_ext.dart';

class NewPatientDatasourceImpl implements NewPatientDatasource {
  final Network _network;
  NewPatientDatasourceImpl(this._network);

  @override
  Future<ResponseNewPatientExt> saveNewPatientDatasource(RequestNewPatient params) async {
    try {
      final response = await _network.post(AppUrl.patient, body: params, isAuth: true);
      if (response.statusCode == null) return ResponseNewPatientExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);

      return ResponseNewPatientExt.fromMap(
        statusCode: response.statusCode,
        data: response.data,
        statusMessage: response.statusMessage,
      );
    } on Exception catch (e, s) {
      AppLog.d("Problema para salvar o paciente $e", stackTrace: s, name: 'saveNewPatientDatasource');
      return ResponseNewPatientExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
    }
  }
}
